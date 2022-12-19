part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props =>[];
}
class AppStartedEvent extends AuthenticationEvent{

}

class LogInEvent extends AuthenticationEvent{
  final String email,password;

  const LogInEvent(this.email, this.password);

}

class UpdateUserToPublisherEvent extends AuthenticationEvent{
  final String userId;
  final Map<String, dynamic>user;

  const UpdateUserToPublisherEvent(this.userId, this.user);
}
class AuthenticationUpdated extends AuthenticationEvent{
  final List<DocumentSnapshot> noticeDocs;

  const AuthenticationUpdated(this.noticeDocs);
}
class FetchAllUsersEvent extends AuthenticationEvent{
}
class FetchPublishersRequestEvent extends AuthenticationEvent{

}
class SignUpEvent extends AuthenticationEvent{
  final UserModel user;
  final File profilePicture;

  const SignUpEvent(this.user,this.profilePicture);

}
class LogOutEvent extends AuthenticationEvent{

}
class ForgetPasswordEvent extends AuthenticationEvent{
  final String email;

  const ForgetPasswordEvent(this.email);

}