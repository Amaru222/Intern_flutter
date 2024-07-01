import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:project/services/user_info.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserInfoGetApi userInfoGetApi;
  ProfileBloc({required this.userInfoGetApi}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    _listenToProfileChange();
    on<LoadDataProfile>(_loadDataProfile);
  }
  void _listenToProfileChange() {
    LoadDataProfile();
  }

  Future<FutureOr<void>> _loadDataProfile(
      LoadDataProfile event, Emitter<ProfileState> emit) async {
    try {
      final userInfo = await userInfoGetApi.getUserInfo();
      emit(ProfileLoaded(userInfo));
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
