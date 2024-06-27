import 'package:dio/dio.dart';
import 'package:project/model/user.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<User> login(String username, String password) async {
    final response = await _dio.post(
        'https://api-school-mng-dev.vais.vn/api/v2/auth/login',
        data: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
