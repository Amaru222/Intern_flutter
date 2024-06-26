part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

class TogglePasswordVisibility extends LoginEvent {}

class LoginRequest extends LoginEvent {
  final String username;
  final String password;

  const LoginRequest({required this.username, required this.password});
}
