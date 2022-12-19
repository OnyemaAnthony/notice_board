import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/repositories/user_repository.dart';

import '../notice/notice_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository? repository;
  StreamSubscription? userStreamSubscription;
  AuthenticationBloc({this.repository}) : super(AuthenticationInitial()) {
    on<AppStartedEvent>(_mapAppStartedEventToState);
    on<LogInEvent>(_mapLoginEventToState);
    on<SignUpEvent>(_mapSignUpEventToState);
    on<LogOutEvent>(_mapLogOutEventToState);
    on<UpdateUserToPublisherEvent>(_mapUpdateUserToPublisherEventToState);
    on<FetchPublishersRequestEvent>(_mapFetchPublishersRequestEventToState);
    on<FetchAllUsersEvent>(_mapFetchAllUsersEventToState);
    on<AuthenticationUpdated>(_mapAuthenticationUpdatedToState);
    on<ForgetPasswordEvent>(_mapForgetPasswordEventToState);
  }

  FutureOr<void> _mapAppStartedEventToState(AppStartedEvent event, Emitter<AuthenticationState> emit) async{
    try {
      bool? isSignedIn = repository!.isSignedIn();
      if (isSignedIn!) {
        UserModel user = await repository!.getUser();
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(UnAuthenticatedState());
    }
  }

  FutureOr<void> _mapLoginEventToState(LogInEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
    try{
      await repository!.logInWithEmailAndPassword(event.email, event.password);
      UserModel user = await repository!.getUser();
      emit(Authenticated(user));
    }catch(e){
      emit(AuthenticationErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserToPublisherEventToState(UpdateUserToPublisherEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    try {
      await repository!.updateUserToPublisher(event.userId, event.user);
      emit(UserUpdatedState());
    } catch (e) {
      emit(AuthenticationErrorState(e.toString()));
    }

  }

  FutureOr<void> _mapSignUpEventToState(SignUpEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
    try {
      var userInfo = await repository!.signUpUserWithEmailAndPassword(event.user.email!, event.user.password!);
      String imageURL = await repository!.uploadProfilePicture(event.profilePicture, userInfo!.uid, 'Pictures');
      event.user.imageURL = imageURL;
       await repository!.saveUser(event.user, userInfo.uid);
      emit(Authenticated(await repository!.getUser()));
    } catch (e) {
      print('error is ${e.toString()}');
     emit(AuthenticationErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapLogOutEventToState(LogOutEvent event, Emitter<AuthenticationState> emit)async {
    emit(AuthenticationLoadingState());
    try{
      await repository!.signOut();
      emit(UnAuthenticatedState());

    }catch(e){
      emit(UnAuthenticatedState());
    }
  }

  FutureOr<void> _mapFetchPublishersRequestEventToState(FetchPublishersRequestEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    try {
      userStreamSubscription?.cancel();
      userStreamSubscription = repository!.fetchPublishersRequest().listen((noticeDoc) {
        add(AuthenticationUpdated(noticeDoc.docs));
      });
    } catch (e) {
      emit(AuthenticationErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapFetchAllUsersEventToState(FetchAllUsersEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    try{
      List<UserModel> users = await repository!.fetchAllUsers();
      emit(UserLoadedState(users));
    }catch(e){
      emit(UnAuthenticatedState());
    }
  }

  FutureOr<void> _mapAuthenticationUpdatedToState(AuthenticationUpdated event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState());
    try{
      List<UserModel> users = event.noticeDocs.map((user) =>UserModel.fromFireStore(user)).toList();
      emit(UserLoadedState(users));
    }catch(e){
      emit(UnAuthenticatedState());
    }
  }

  FutureOr<void> _mapForgetPasswordEventToState(ForgetPasswordEvent event, Emitter<AuthenticationState> emit)async {
    try{
      repository!.forgetPassword(event.email);
      emit(PasswordUpdatedState());

    }catch(e){
      emit(AuthenticationErrorState(e.toString()));
    }
  }
}