import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {});
    // on<LoadDataSetting>(_loadDataSetting);
  }

  FutureOr<void> _loadDataSetting(
      LoadDataSetting event, Emitter<SettingState> emit) {}
}
