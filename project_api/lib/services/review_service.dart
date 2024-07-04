import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  final Dio dio;

  ReviewService({required this.dio});
  Future<Map<String, dynamic>> getListStudent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/teachers/students',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load list student');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getListReView() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/reviews',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load list review');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
