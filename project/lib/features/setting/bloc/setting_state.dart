part of 'setting_bloc.dart';

@immutable
sealed class SettingState extends Equatable {
  const SettingState();
  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final String nameUser;
  final String classInfo;
  final String title;

  const SettingLoaded(this.nameUser, this.classInfo, this.title);
  @override
  List<Object> get props => [nameUser, classInfo, title];
}

class SettingError extends SettingState {
  final String message;
  const SettingError(this.message);
  @override
  List<Object> get props => [message];
}
