part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
class AppStartedEvent extends AuthenticationEvent{
  @override

  List<Object?> get props => [];

}

class LogInEvent extends AuthenticationEvent{
  final String email,password;

  const LogInEvent(this.email, this.password);

  @override
  List<Object?> get props =>[];

}
class SignUpEvent extends AuthenticationEvent{
  final UserModel user;
  final File profilePicture;

  const SignUpEvent(this.user,this.profilePicture);

  @override
  List<Object?> get props =>[];

}
class LogOutEvent extends AuthenticationEvent{
  @override
  List<Object?> get props =>[];

}