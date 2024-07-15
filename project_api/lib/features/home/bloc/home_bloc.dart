import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:project/model/user.dart';
import 'package:project/services/user_info.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserInfoGetApi userInfoGetApi;
  User? cachedUser;

  HomeBloc(this.userInfoGetApi) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<LoadDataHome>(_loadDataHome);
  }

  Future<void> _loadDataHome(
      LoadDataHome event, Emitter<HomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('userInfo');
      if (cachedData != null) {
        final userInfo = jsonDecode(cachedData);
        final user = User.fromMap(userInfo);
        emit(HomeLoaded(user));
      } else {
        final userInfo = await userInfoGetApi.getUserInfo();
        final user = User.fromMap(userInfo);
        prefs.setString(
            'userInfo', jsonEncode(userInfo)); 
        emit(HomeLoaded(user));
      }
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}
