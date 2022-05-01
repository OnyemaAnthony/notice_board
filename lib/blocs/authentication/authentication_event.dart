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
class SignUpEvent extends AuthenticationEvent{
  final UserModel user;
  final File profilePicture;

  const SignUpEvent(this.user,this.profilePicture);

}
class LogOutEvent extends AuthenticationEvent{

}