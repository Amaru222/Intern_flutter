import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth_service.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final AuthService authService;

  TokenInterceptor({required this.dio, required this.authService});

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await authService.refreshToken();
        final prefs = await SharedPreferences.getInstance();
        final newToken = prefs.getString('token');
        final options = Options(
          headers: {'Authorization': 'Bearer $newToken'},
        );

        final response = await dio.request(
          err.requestOptions.path,
          options: options,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }
}
