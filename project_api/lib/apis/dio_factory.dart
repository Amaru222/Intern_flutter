import 'package:dio/dio.dart';
import 'package:project/apis/refreshToken/token_interceptor.dart';
import 'package:project/services/auth_service.dart';

Dio createDio() {
  final dio = Dio();
  final authService = AuthService(dio: dio);
  final interceptor = TokenInterceptor(dio: dio, authService: authService);
  dio.interceptors.add(interceptor);
  dio.options = BaseOptions(
    baseUrl: 'https://api-school-mng-dev.vais.vn',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
  return dio;
}
