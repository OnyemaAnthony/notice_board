import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc() : super(NoticeInitial()) {
    on<NoticeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
