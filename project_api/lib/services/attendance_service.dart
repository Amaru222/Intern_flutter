import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  final Dio dio;

  AttendanceService({required this.dio});

  Future<Map<String, dynamic>> getListStudentAttendance() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/teachers/attendance-students?filter[dateAt]=$formattedDate',
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
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> postCheckIn(List<String> studentIds) async {
    try {
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.post(
        'https://api-school-mng-dev.vais.vn/api/teachers/check-in-students',
        data: {
          'studentIds': studentIds,
          'checkIn': formattedDateTime,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Check-in successful for studentIds: $studentIds');
      } else {
        throw Exception('Failed to check-in for studentIds: $studentIds');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> postCheckOut(List<String> studentIds) async {
    try {
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.post(
        'https://api-school-mng-dev.vais.vn/api/teachers/check-in-students',
        data: {
          'studentIds': studentIds,
          'checkOut': formattedDateTime,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Check-in successful for studentIds: $studentIds');
      } else {
        throw Exception('Failed to check-in for studentIds: $studentIds');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getListStudentAttendanceDate(String date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await dio.get(
        'https://api-school-mng-dev.vais.vn/api/teachers/attendance-students?filter[dateAt]=$date',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load list student attendance');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
