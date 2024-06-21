part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

// ignore: camel_case_types
class LoadDataSetting extends SettingEvent {}

class SettingUpdated extends SettingEvent {
  final String nameUser;
  final String classInfo;
  final String title;
  SettingUpdated(this.nameUser, this.classInfo, this.title);
  @override
  List<Object> get props => [nameUser, classInfo, title];
}
