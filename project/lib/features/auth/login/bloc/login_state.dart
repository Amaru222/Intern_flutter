part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@immutable
class LoginState extends Equatable {
  final bool isPasswordObscured;
  final LoginStatus status;
  final String errorMessage;
  const LoginState(
      {required this.isPasswordObscured,
      required this.status,
      required this.errorMessage});

  LoginState copyWith(
      {bool? isPasswordObscured, LoginStatus? status, String? errorMessage}) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isPasswordObscured, status, errorMessage];
}

final class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
            isPasswordObscured: true,
            status: LoginStatus.initial,
            errorMessage: '');
}
