import 'package:flutter/material.dart';
import 'package:project/component/bottomnavigationbar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('attendance'),
      bottomNavigationBar: BottomBar(
        currentIndex: 1,
      ),
    );
  }
}
