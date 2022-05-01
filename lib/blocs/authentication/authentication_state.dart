part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState{
  final UserModel user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class UnAuthenticatedState extends AuthenticationState{
  @override
  List<Object?> get props => [];

}
class AuthenticationErrorState extends AuthenticationState{
  final String errorMessage;

 const AuthenticationErrorState(this.errorMessage);
  @override
  List<Object?> get props => [];

}


class AuthenticationLoadingState extends AuthenticationState{
  @override
  List<Object?> get props => [];

}