import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Dio dio;
  ProfileBloc({required this.dio}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadDataProfile>(_loadDataProfile);
    _listenToProfileChange();
  }
  void _listenToProfileChange() {}

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<FutureOr<void>> _loadDataProfile(
      LoadDataProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/attendances/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        emit(ProfileLoaded(response.data));
      } else {
        emit(const ProfileError('Failed to load profile'));
      }
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
