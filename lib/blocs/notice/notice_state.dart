part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();
}

class NoticeInitial extends NoticeState {
  @override
  List<Object> get props => [];
}
