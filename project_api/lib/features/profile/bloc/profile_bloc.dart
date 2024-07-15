import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:project/model/user.dart';

import 'package:project/services/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserInfoGetApi userInfoGetApi;
  ProfileBloc({required this.userInfoGetApi}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadDataProfile>(_loadDataProfile);
  }

  Future<FutureOr<void>> _loadDataProfile(
      LoadDataProfile event, Emitter<ProfileState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('userInfo');
      if (cachedData != null) {
        final userInfo = jsonDecode(cachedData);
        final user = User.fromMap(userInfo);
        emit(ProfileLoaded(user));
      } else {
        final userInfo = await userInfoGetApi.getUserInfo();
        final user = User.fromMap(userInfo);
        prefs.setString('userInfo', jsonEncode(userInfo));
        emit(ProfileLoaded(user));
      }
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
