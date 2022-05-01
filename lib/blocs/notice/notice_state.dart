part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();
}

class NoticeInitial extends NoticeState {
  @override
  List<Object> get props => [];
}
class NoticeLoadingState extends NoticeState{
  @override
  List<Object?> get props => [];

}
class NoticeLoadedState extends NoticeState{
  final List<DocumentSnapshot> noticeDocs;

  const NoticeLoadedState(this.noticeDocs);

  @override
  List<Object?> get props =>[];

}
class NoticeErrorSate extends NoticeState{
  final String errorMessage;

 const NoticeErrorSate(this.errorMessage);
  @override
  List<Object?> get props => [];

}
