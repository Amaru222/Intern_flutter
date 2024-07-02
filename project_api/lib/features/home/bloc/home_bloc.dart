import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/apis/refreshToken/token_interceptor.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  Dio _createDio() {
    final dio = Dio();
    final authService = AuthService(dio: dio);
    dio.interceptors.add(TokenInterceptor(dio: dio, authService: authService));
    dio.options = BaseOptions(
      baseUrl: 'https://api-school-mng-dev.vais.vn',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    return dio;
  }
}
