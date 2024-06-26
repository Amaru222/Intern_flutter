part of 'change_password_bloc.dart';

sealed class ChangePasswordState {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}
