part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();
}

class CreateNoticeEvent extends NoticeEvent{
  final NoticeModel notice;

  const CreateNoticeEvent(this.notice);

  @override
  List<Object?> get props =>[];
}

class NoticeUpdated extends NoticeEvent{
  final List<DocumentSnapshot> noticeDocs;

 const NoticeUpdated(this.noticeDocs);

  @override
  List<Object?> get props =>[];

}
class GetAllNoticeEvent extends NoticeEvent{
  @override
  List<Object?> get props => [];

}

class DeleteNoticeEvent extends NoticeEvent{
  final String noticeI;

const DeleteNoticeEvent(this.noticeI);
  @override
  List<Object?> get props =>[];
}