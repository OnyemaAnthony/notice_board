part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();
  @override
  List<Object?> get props => [];
}

class CreateNoticeEvent extends NoticeEvent{
  final NoticeModel notice;
  final File file;

  const CreateNoticeEvent(this.notice,this.file);
}

class NoticeUpdated extends NoticeEvent{
  final List<DocumentSnapshot> noticeDocs;

 const NoticeUpdated(this.noticeDocs);
}
class GetAllNoticeEvent extends NoticeEvent{

}

class DeleteNoticeEvent extends NoticeEvent{
  final String noticeId;

  const DeleteNoticeEvent(this.noticeId);

}
class FetchNoticeRequestEvent extends NoticeEvent{

}
class FetchPublishersNoticeEvent extends NoticeEvent{
  final String publishersId;

  const FetchPublishersNoticeEvent(this.publishersId);
}
class ApproveNoticeEvent extends NoticeEvent{
  final Map<String,dynamic> noticeMap;
  final String noticeId;

  const ApproveNoticeEvent(this.noticeMap,this.noticeId);

}


