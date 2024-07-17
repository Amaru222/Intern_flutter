part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class ToEnglish extends LanguageEvent {}

class ToVietnamese extends LanguageEvent {}
