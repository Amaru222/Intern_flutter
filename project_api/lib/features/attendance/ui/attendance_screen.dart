import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/apis/dio_factory.dart';
import 'package:project/component/bottomnavigationbar.dart';
import 'package:project/features/attendance/bloc/attendance_bloc.dart';
import 'package:project/features/attendance/component/search_field.dart';
import 'package:project/services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceBloc _attendanceBloc;
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    final dio = createDio();
    final attendanceService = AttendanceService(dio: dio);

    super.initState();
    _attendanceBloc = AttendanceBloc(attendanceService)..add(LoadStudent());
  }

  @override
  void dispose() {
    _attendanceBloc.close();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      _attendanceBloc.add(ChangeDate(formattedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _attendanceBloc,
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AttendanceLoaded) {
              return Stack(children: [
                Container(
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
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate),
                                    style: const TextStyle(
                                        color: Color(0xff141416),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          searchField(),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 18),
                                child: Text(
                                  ' Học sinh',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: GestureDetector(
                                    onTap: () {
                                      bool allSelected = state
                                          .selectedCheckboxes
                                          .every((element) => element);
                                      _attendanceBloc.add(SelectAllCheckbox(
                                          isSelected: !allSelected));
                                    },
                                    child: const Text(
                                      'Chọn tất cả',
                                      style: TextStyle(
                                          color: Color(0xff4d5fff),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount:
                                  state.listStudent['data']['items'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: listAttendance(
                                      index: index,
                                      isChecked:
                                          state.selectedCheckboxes[index],
                                      listStudent: state.listStudent),
                                );
                              })
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width * 0.5) -
                                  28,
                              padding: const EdgeInsets.only(
                                top: 3,
                                bottom: 3,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xff59a975),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AttendanceBloc>(context)
                                        .add(AttendButtonPressed());
                                  },
                                  child: const Text('Vào lớp',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width * 0.5) -
                                  28,
                              padding: const EdgeInsets.only(
                                top: 3,
                                bottom: 3,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xffc52227),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AttendanceBloc>(context)
                                        .add(LeaveButtonPressed());
                                  },
                                  child: const Text(
                                    'Ra Ngoài',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )),
                            )
                          ],
                        )))
              ]);
            } else if (state is AttendanceError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                child: Text('loix'),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }

  Widget listAttendance(
      {required int index,
      required bool isChecked,
      required Map<String, dynamic> listStudent}) {
    final name = listStudent['data']['items'][index]['name'];
    // final avatar = listStudent['data']['items'][index]['avatar']['url'];

    final typeAttendance =
        listStudent['data']['items'][index]['attendance']['type'];
    String textTypeAttendance;
    final Color colorTypeAttendance;
    if (typeAttendance == 'absence') {
      textTypeAttendance = 'Vắng mặt';
      colorTypeAttendance = const Color.fromARGB(255, 227, 48, 48);
    } else if (typeAttendance == 'check-in') {
      textTypeAttendance = 'Đã vào lớp';
      colorTypeAttendance = const Color(0xff59a975);
    } else {
      textTypeAttendance = 'Chưa vào lớp';
      colorTypeAttendance = const Color(0xfff79525);
    }
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
                  value: isChecked,
                  onChanged: (bool? value) {
                    _attendanceBloc.add(ToggleCheckbox(index: index));
                  },
                ),
                const CircleAvatar(
                  minRadius: 20,
                  maxRadius: 25,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 2, right: 5, left: 5, bottom: 2),
                    decoration: BoxDecoration(
                      color: colorTypeAttendance,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      children: [
                        Text(
                          textTypeAttendance,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
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
