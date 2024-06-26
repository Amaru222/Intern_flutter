import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/attendance.dart';
import 'package:project/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AttendanceRepository {
  final FirebaseFirestore firestore;
  final auth.FirebaseAuth firebaseAuth;
  AttendanceRepository({required this.firestore, required this.firebaseAuth});
  Future<List<Attendance>> fetchStudentsAttendanceInClass(
      String className, String formattedDate) async {
    final snapshot = await firestore
        .collection('attendance')
        .where('class', isEqualTo: className)
        .where('date', isEqualTo: formattedDate)
        .get();
    return snapshot.docs.map((doc) => Attendance.fromMap(doc.data())).toList();
  }

  Future<void> updateUserAttendance(
      List<String> selectedUids, String className, String formattedDate) async {
    try {
      final querySnapshot = await firestore
          .collection('attendance')
          .where('class', isEqualTo: className)
          .where('date', isEqualTo: formattedDate)
          .get();

      for (var doc in querySnapshot.docs) {
        List<UserAttendance> updatedUserAttendance = [];
        for (var ua in doc.data()['userAttendance']) {
          if (selectedUids.contains(ua['uid'])) {
            ua['isAttendance'] = true;
          }
          updatedUserAttendance.add(UserAttendance.fromMap(ua));
        }
        await doc.reference.update({
          'userAttendance':
              updatedUserAttendance.map((ua) => ua.toMap()).toList(),
        });
      }
    } catch (e) {
      throw Exception('Failed to mark attendance: $e');
    }
  }

  Future<void> updateUserLeave(
      List<String> selectedUids, String className, String formattedDate) async {
    try {
      final querySnapshot = await firestore
          .collection('attendance')
          .where('class', isEqualTo: className)
          .where('date', isEqualTo: formattedDate)
          .get();

      for (var doc in querySnapshot.docs) {
        List<UserAttendance> updatedUserAttendance = [];
        for (var ua in doc.data()['userAttendance']) {
          if (selectedUids.contains(ua['uid'])) {
            ua['isAttendance'] = false;
          }
          updatedUserAttendance.add(UserAttendance.fromMap(ua));
        }
        await doc.reference.update({
          'userAttendance':
              updatedUserAttendance.map((ua) => ua.toMap()).toList(),
        });
      }
    } catch (e) {
      throw Exception('Failed to mark attendance: $e');
    }
  }
}
