part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();
}

class CreateNoticeEvent extends NoticeEvent{

  @override
  List<Object?> get props =>[];
}

class DeleteNoticeEvent extends NoticeEvent{
  final String noticeI;

const DeleteNoticeEvent(this.noticeI);
  @override
  List<Object?> get props =>[];
}