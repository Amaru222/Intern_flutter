part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

// ignore: camel_case_types
class LoadDataSetting extends SettingEvent {}

class ChangeLanguage extends SettingEvent {
  final Locale newLocale;

  ChangeLanguage(this.newLocale);
}
