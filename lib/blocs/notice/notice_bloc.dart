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
  }

  FutureOr<void> _mapGetAllNoticeEventToState(GetAllNoticeEvent event, Emitter<NoticeState> emit)async {
    emit(NoticeLoadingState());
    noticeSubscription?.cancel();
    noticeSubscription = repository.getAttendances(event.parishID).listen((attendanceDoc) {
      add(NoticeUpdated(attendanceDoc.docs));
    });
  }
}
