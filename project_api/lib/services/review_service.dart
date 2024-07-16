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

  Future<Map<String, dynamic>> getListReViewLast(String studentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/reviews?filter[studentId]=$studentId&limit=1&page=1&sort[createdAt]=-1',
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

  Future<Map<String, dynamic>> getListReViewAll(String studentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/reviews?filter[studentId]=$studentId&limit=10&page=1&sort[createdAt]=-1',
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

  Future<void> postCreateReView(
      {required String message,
      required String classId,
      required String schoolLevel,
      required String studentId,
      required String teacherId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.post(
        'https://api-school-mng-dev.vais.vn/api/reviews',
        data: {
          "record": {
            "message": message,
            "classId": classId,
            "schoolLevel": schoolLevel,
            "studentId": studentId,
            "teacherId": teacherId,
          }
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('create review success');
      } else {
        throw Exception('Failed to create review');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> patchUpdateReview(
      {required String messageId,
      required String message,
      required String classId,
      required String schoolLevel,
      required String studentId,
      required String teacherId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.patch(
        'https://api-school-mng-dev.vais.vn/api/reviews/$messageId',
        data: {
          "record": {
            "message": message,
            "classId": classId,
            "schoolLevel": schoolLevel,
            "studentId": studentId,
            "teacherId": teacherId,
          }
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('post review success');
      } else {
        throw Exception('Failed update review');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteReview({
    required String messageId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.delete(
        'https://api-school-mng-dev.vais.vn/api/reviews/$messageId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('delete review success');
      } else {
        throw Exception('Failed to delete review');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
