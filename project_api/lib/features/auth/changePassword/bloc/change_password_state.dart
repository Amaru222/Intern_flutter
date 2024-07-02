part of 'change_password_bloc.dart';

class ChangePasswordState {
  final List<bool> isPasswordObscured;
  final bool isLoading;
  final String? error;

  ChangePasswordState({
    required this.isPasswordObscured,
    this.isLoading = false,
    this.error,
  });
  ChangePasswordState copyWith({
    List<bool>? isPasswordObscured,
    bool? isLoading,
    String? error,
  }) {
    return ChangePasswordState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
