import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Dio dio;
  LoginBloc({required this.dio}) : super(const LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginRequest>(_loginRequest);
  }
  FutureOr<void> _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<FutureOr<void>> _loginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final response = await dio
          .post('https://api-school-mng-dev.vais.vn/api/v2/auth/login', data: {
        'username': event.username,
        'password': event.password,
        'role': 'teacher'
      });
      // print('Response: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
        final accessToken = data['data']['tokens']['access']['token'];
        final refreshToken = data['data']['tokens']['refresh']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        emit(state.copyWith(status: LoginStatus.success, user: response.data));
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure, errorMessage: 'Login failed'));
      }
    } catch (error) {
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: error.toString()));
    }
  }
}
