import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    print(refreshToken);
    if (refreshToken == null) {
      throw Exception('Refresh token not found');
    }
    try {
      final response = await dio.post(
        'https://api-school-mng-dev.vais.vn/api/v2/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      if (response.statusCode == 200) {
        final newRefreshToken =
            response.data['data']['tokens']['refresh']['token'];
        await prefs.setString('refreshToken', newRefreshToken);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (error) {
      throw Exception('Failed to refresh token: $error');
    }
  }
}
