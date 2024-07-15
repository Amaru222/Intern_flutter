import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/apis/dio_factory.dart';

import 'package:project/component/bottomnavigationbar.dart';
import 'package:project/features/home/bloc/home_bloc.dart';
import 'package:project/model/user.dart';
import 'package:project/services/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dio = createDio();
    final userInfoGetApi = UserInfoGetApi(dio: dio);
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(userInfoGetApi)..add(LoadDataHome()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoaded) {
              return buildHomeUi(state.userProfile);
            } else if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('loi'),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 0,
      ),
    );
  }

  Widget buildHomeUi(User userProfile) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/icon_home/header_home.png'),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        const Image(
                            image: AssetImage('assets/images/avatar.png')),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              '${userProfile.nameRole} : ${userProfile.classInfo}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/icon_home/notification.png'),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.19,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              children: [
                GridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildIconButton(
                        'assets/images/icon_home/icon_calendar.png',
                        'Thời khóa biểu'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_attendance.png',
                        'Điểm danh'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_test_schedule.png',
                        'Lịch thi'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_transcript.png',
                        'Bảng điểm'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_comment.png', 'Nhận xét'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_message.png', 'Tin nhắn'),
                    _buildIconButton(
                        'assets/images/icon_home/icon_menu.png', 'Thực đơn'),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Thông báo',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image(
                        image:
                            AssetImage('assets/images/icon_home/firework.png'))
                  ],
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const Column(
                        children: [
                          Card(
                            color: Color(0xfff5f4f4),
                            child: ListTile(
                              title: Text(
                                'Thông báo lịch thi học kì 1 năm 2021-2022',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('15/11/2022 08:00'),
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(String nameIcon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Image.asset(nameIcon),
          color: Colors.red,
          onPressed: () async {
            if (label == 'Nhận xét') {
              context.go('/home/review');
            } else if (label == 'Thời khóa biểu') {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              // ignore: use_build_context_synchronously
              context.go('/');
            } else if (label == 'Điểm danh') {
            } else if (label == 'Lịch thi') {
            } else if (label == 'Bảng điểm') {}
          },
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
