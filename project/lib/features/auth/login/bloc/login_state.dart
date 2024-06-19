part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isPasswordObscured;

  const LoginState({required this.isPasswordObscured});

  LoginState copyWith({bool? isPasswordObscured}) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object> get props => [isPasswordObscured];
}

final class LoginInitial extends LoginState {
  const LoginInitial() : super(isPasswordObscured: true);
}
