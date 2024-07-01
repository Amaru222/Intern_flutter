part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class TogglePasswordVisibility extends ChangePasswordEvent {
  final int index;

  TogglePasswordVisibility(this.index);
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String passwordOld;
  final String passwordNew;

  ChangePasswordSubmitted(this.passwordOld, this.passwordNew);
}
