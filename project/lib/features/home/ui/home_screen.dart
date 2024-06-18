import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  List<String> navIcons = [
    'assets/images/home_smile.png',
    'assets/images/calendar_event.png',
    'assets/images/chat_smile.png',
    'assets/images/settings.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/header_home.png'),
                          fit: BoxFit.cover)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 32,
                          ),
                          Image(image: AssetImage('assets/images/avatar.png')),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lê Toàn Đức',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                'Giáo viên chủ nhiệm: 1A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/notification.png'),
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
                          'assets/images/icon_calendar.png', 'Thời khóa biểu'),
                      _buildIconButton(
                          'assets/images/icon_attendance.png', 'Điểm danh'),
                      _buildIconButton(
                          'assets/images/icon_test_schedule.png', 'Lịch thi'),
                      _buildIconButton(
                          'assets/images/icon_transcript.png', 'Bảng điểm'),
                      _buildIconButton(
                          'assets/images/icon_comment.png', 'Nhận xét'),
                      _buildIconButton(
                          'assets/images/icon_message.png', 'Tin nhắn'),
                      _buildIconButton(
                          'assets/images/icon_menu.png', 'Thực đơn'),
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Thông báo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image(image: AssetImage('assets/images/firework.png'))
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
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  // curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex
                        ? 0
                        : MediaQuery.of(context).size.width * .029,
                    right: MediaQuery.of(context).size.width * .0422,
                    left: MediaQuery.of(context).size.width * .0422,
                  ),
                  width: MediaQuery.of(context).size.width * .128,
                  height: index == currentIndex
                      ? MediaQuery.of(context).size.width * .014
                      : 0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                ),
                Image(image: AssetImage(navIcons[index])),
                SizedBox(height: MediaQuery.of(context).size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildIconButton(String nameIcon, String label) {
  return Column(
    children: [
      IconButton(
        icon: Image.asset(nameIcon),
        color: Colors.red,
        onPressed: () {},
      ),
      Text(
        label,
        style: const TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
