part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends LoginEvent {}

class LoginRequest extends LoginEvent {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
