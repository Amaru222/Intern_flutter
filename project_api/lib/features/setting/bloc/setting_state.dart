part of 'setting_bloc.dart';

@immutable
sealed class SettingState {
  const SettingState();
}

final class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final String nameUser;
  final String classInfo;
  final String title;

  const SettingLoaded(this.nameUser, this.classInfo, this.title);
}

class SettingError extends SettingState {
  final String message;
  const SettingError(this.message);
}
