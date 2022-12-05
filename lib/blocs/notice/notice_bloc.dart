import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:notice_board/models/notice_model.dart';

import '../../repositories/notice_repository.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeRepository? repository;
  StreamSubscription? noticeSubscription;
  NoticeBloc({this.repository}) : super(NoticeInitial()) {
    on<GetAllNoticeEvent>(_mapGetAllNoticeEventToState);
    on<NoticeUpdated>(_mapNoticeUpdatedToState);
    on<CreateNoticeEvent>(_mapCreateNoticeEventToState);
    on<DeleteNoticeEvent>(_mapDeleteNoticeEventToState);
    on<FetchPublishersNoticeEvent>(_mapFetchPublishersNoticeEventToState);
    on< FetchNoticeRequestEvent>(_mapFetchNoticeRequestEventToState);
    on< ApproveNoticeEvent>(_mapApproveNoticeEventToState);

  }

  FutureOr<void> _mapGetAllNoticeEventToState(GetAllNoticeEvent event, Emitter<NoticeState> emit)async {
    emit(NoticeLoadingState());

    try {
      noticeSubscription?.cancel();
      noticeSubscription = repository!.getAllNotice().listen((noticeDoc) {
        add(NoticeUpdated(noticeDoc.docs));
      });
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
  }

  FutureOr<void> _mapNoticeUpdatedToState(NoticeUpdated event, Emitter<NoticeState> emit) async{
    emit(NoticeLoadingState());
    try {
      emit(NoticeLoadedState(event.noticeDocs));
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
  }

  FutureOr<void> _mapCreateNoticeEventToState(CreateNoticeEvent event, Emitter<NoticeState> emit) async{
    emit(NoticeLoadingState());
    try {
      await repository!.saveNotice(event.notice);
      emit(NoticeAddedState());
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
  }

  FutureOr<void> _mapDeleteNoticeEventToState(DeleteNoticeEvent event, Emitter<NoticeState> emit)async {
    emit(NoticeLoadingState());
    try {
      await repository!.deleteNotice(event.noticeId);
      emit(NoticeAddedState());
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
  }

  FutureOr<void> _mapFetchPublishersNoticeEventToState(FetchPublishersNoticeEvent event, Emitter<NoticeState> emit) async{
    emit(NoticeLoadingState());

    try {
      noticeSubscription?.cancel();
      noticeSubscription = repository!.fetchPublishersNotice(event.publishersId).listen((noticeDoc) {
        add(NoticeUpdated(noticeDoc.docs));
      });
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
    
  }


  FutureOr<void> _mapFetchNoticeRequestEventToState(FetchNoticeRequestEvent event, Emitter<NoticeState> emit) async{
    emit(NoticeLoadingState());
    try {
      noticeSubscription?.cancel();
      noticeSubscription = repository!.fetchNoticeRequest().listen((noticeDoc) {
        add(NoticeUpdated(noticeDoc.docs));
      });
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }
  }

  FutureOr<void> _mapApproveNoticeEventToState(ApproveNoticeEvent event, Emitter<NoticeState> emit) async{
    emit(NoticeLoadingState());
    try {
      repository!.approveNotice(event.noticeId, event.noticeMap);
      emit(NoticeAddedState());
    } catch (e) {
      emit(NoticeErrorSate(e.toString()));
    }

  }
}
