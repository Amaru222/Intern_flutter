import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/model/user.dart';
import 'package:project/services/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserInfoGetApi userInfoGetApi;
  SettingBloc({required this.userInfoGetApi}) : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {});
    _listenToProfileChange();
    on<LoadDataSetting>(_loadDataSetting);
    // on<ChangeLanguage>(_changeLanguage);
  }
  void _listenToProfileChange() {
    LoadDataSetting();
  }

  Future<FutureOr<void>> _loadDataSetting(
      LoadDataSetting event, Emitter<SettingState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('userInfo');
      if (cachedData != null) {
        final userInfo = jsonDecode(cachedData);
        final user = User.fromMap(userInfo);
        emit(SettingLoaded(user));
      } else {
        final userInfo = await userInfoGetApi.getUserInfo();
        final user = User.fromMap(userInfo);
        prefs.setString('userInfo', jsonEncode(userInfo));
        emit(SettingLoaded(user));
      }
    } catch (error) {
      emit(SettingError(error.toString()));
    }
  }
}
