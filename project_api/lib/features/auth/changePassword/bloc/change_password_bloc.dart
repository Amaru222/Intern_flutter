import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc()
      : super(ChangePasswordState(isPasswordObscured: [true, true, true])) {
    on<ChangePasswordEvent>((event, emit) {});
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ChangePasswordSubmitted>(_changePasswordSubmitted);
  }
  final Dio _dio = Dio();
  FutureOr<void> _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<ChangePasswordState> emit) {
    final updatedList = List<bool>.from(state.isPasswordObscured);
    updatedList[event.index] = !updatedList[event.index];
    emit(state.copyWith(isPasswordObscured: updatedList));
  }

  Future<FutureOr<void>> _changePasswordSubmitted(
      ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await _dio.patch(
        'https://api-school-mng-dev.vais.vn/api/v2/auth/changing-password',
        data: {
          'oldPassword': event.passwordOld,
          'newPassword': event.passwordNew,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(isLoading: false, error: null));
      } else {
        emit(
            state.copyWith(isLoading: false, error: 'Error changing password'));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: 'Error changing password: $e'));
    }
  }
}
