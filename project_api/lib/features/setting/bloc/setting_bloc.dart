import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/apis/user_info.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserInfoGetApi userInfoGetApi;
  SettingBloc({required this.userInfoGetApi}) : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {});
    _listenToProfileChange();
    on<LoadDataSetting>(_loadDataSetting);
  }
  void _listenToProfileChange() {
    LoadDataSetting();
  }

  Future<FutureOr<void>> _loadDataSetting(
      LoadDataSetting event, Emitter<SettingState> emit) async {
    try {
      final userInfo = await userInfoGetApi.getUserInfo();
      emit(SettingLoaded(userInfo));
    } catch (error) {
      emit(SettingError(error.toString()));
    }
  }
}
