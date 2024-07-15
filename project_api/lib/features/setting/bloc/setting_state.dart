part of 'setting_bloc.dart';

@immutable
sealed class SettingState {
  const SettingState();
}

final class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final User userProfile;

  const SettingLoaded(
    this.userProfile,
  );
}

class SettingError extends SettingState {
  final String message;
  const SettingError(this.message);
}
