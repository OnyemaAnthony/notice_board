part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
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

  const SignUpEvent(this.user);

  @override
  List<Object?> get props =>[];

}
class LogOutEvent extends AuthenticationEvent{
  @override
  List<Object?> get props =>[];

}