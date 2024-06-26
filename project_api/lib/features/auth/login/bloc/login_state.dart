part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@immutable
class LoginState {
  final bool isPasswordObscured;
  final LoginStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? user;
  const LoginState(
      {this.isPasswordObscured = true,
      this.status = LoginStatus.initial,
      this.errorMessage,
      this.user});

  LoginState copyWith({
    bool? isPasswordObscured,
    LoginStatus? status,
    String? errorMessage,
    Map<String, dynamic>? user,
  }) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}

final class LoginInitial extends LoginState {
  const LoginInitial() : super();
}
