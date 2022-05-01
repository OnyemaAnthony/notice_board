part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();
  @override
  List<Object?> get props =>[];
}

class NoticeInitial extends NoticeState {

}
class NoticeLoadingState extends NoticeState{


}
class NoticeLoadedState extends NoticeState{
  final List<DocumentSnapshot> noticeDocs;

  const NoticeLoadedState(this.noticeDocs);



}
class NoticeErrorSate extends NoticeState{
  final String errorMessage;

 const NoticeErrorSate(this.errorMessage);
  @override
  List<Object?> get props => [];

}
