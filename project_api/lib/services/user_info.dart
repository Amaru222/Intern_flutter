import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoGetApi {
  final Dio dio;
  UserInfoGetApi({required this.dio});
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/v2/auth/user-info',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
