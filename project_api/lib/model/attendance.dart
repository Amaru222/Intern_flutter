import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String className;
  final String date;
  final List<UserAttendance> userAttendance;

  Attendance({
    required this.className,
    required this.date,
    required this.userAttendance,
  });

  factory Attendance.fromMap(Map<String, dynamic> data) {
    var userAttendanceList = (data['userAttendance'] as List)
        .map((item) => UserAttendance.fromMap(item))
        .toList();

    return Attendance(
      className: data['class'],
      date: data['date'],
      userAttendance: userAttendanceList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class': className,
      'date': date,
      'userAttendance': userAttendance.map((item) => item.toMap()).toList(),
    };
  }
}

class UserAttendance {
  final bool isAttendance;
  final String uid;

  UserAttendance({
    required this.isAttendance,
    required this.uid,
  });

  factory UserAttendance.fromMap(Map<String, dynamic> data) {
    return UserAttendance(
      isAttendance: data['isAttendance'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAttendance': isAttendance,
      'uid': uid,
    };
  }
}
