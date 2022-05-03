part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {

}

class Authenticated extends AuthenticationState{
  final UserModel user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdatedState extends AuthenticationState{

}
class UnAuthenticatedState extends AuthenticationState{

}
class AuthenticationErrorState extends AuthenticationState{
  final String errorMessage;

 const AuthenticationErrorState(this.errorMessage);


}


class AuthenticationLoadingState extends AuthenticationState{


}