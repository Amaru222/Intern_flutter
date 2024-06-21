import 'package:flutter/material.dart';

import 'package:project/component/bottomnavigationbar.dart';

import 'package:project/features/attendance/component/search_field.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "Ngày ${now.day}/${now.month}/${now.year}";
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Điểm danh',
                    style: TextStyle(
                        color: Color(0xff141416),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                        color: Color(0xff141416),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(height: 15),
                searchField(),
                const SizedBox(height: 15),
                listAttendance(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }

  Widget listAttendance() {
    return Container(
        margin: const EdgeInsets.only(right: 16, left: 16),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: const Color(0xfff5f4f4),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? Value) {},
                ),
                const CircleAvatar(
                  minRadius: 20,
                  maxRadius: 25,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Lê Toàn Đức',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 2, right: 5, left: 5, bottom: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xff59a975),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Đã vào lớp',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
          ],
        ));
  }
}
