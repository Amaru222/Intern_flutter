import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      emit(LanguageLoaded(const Locale('vi', 'VN')));
    });
    on<ToEnglish>(_toEnglish);
    on<ToVietnamese>(_toVietNamese);
  }

  Future<FutureOr<void>> _toEnglish(
      ToEnglish event, Emitter<LanguageState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('languageCode', 'en');
    emit(LanguageLoaded(const Locale('en', 'US')));
  }

  Future<FutureOr<void>> _toVietNamese(
      ToVietnamese event, Emitter<LanguageState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('languageCode', 'vi');
    emit(LanguageLoaded(const Locale('vi', 'VN')));
  }
}
