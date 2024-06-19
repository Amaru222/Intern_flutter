import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/component/bottomnavigationbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingsItems = [
      {
        'icon': 'assets/images/icon_setting_screen/profile.png',
        'title': 'Thông tin chi tiết',
        'trailing': Icons.arrow_forward_ios,
        'onTap': () {
          context.go('/setting/profile');
        },
      },
      {
        'icon': 'assets/images/icon_setting_screen/change_password.png',
        'title': 'Thay đổi mật khẩu',
        'trailing': Icons.arrow_forward_ios,
        'onTap': () {
          context.go('/setting/changeassword');
        },
      },
      {
        'icon': 'assets/images/icon_setting_screen/language.png',
        'title': 'Ngôn ngữ',
        'trailing': const Text('Vietnamese', style: TextStyle(fontSize: 14)),
        'onTap': () {},
      },
      {
        'icon': 'assets/images/icon_setting_screen/notification.png',
        'title': 'Cài đặt thông báo',
        'trailing': Icons.arrow_forward_ios,
        'onTap': () {},
      },
      {
        'icon': 'assets/images/icon_setting_screen/guide.png',
        'title': 'Hướng dẫn sử dụng',
        'trailing': Icons.arrow_forward_ios,
        'onTap': () {},
      },
      {
        'icon': 'assets/images/icon_setting_screen/version.png',
        'title': 'Phiên bản',
        'trailing': const Text(
          '2.2.2',
          style: TextStyle(fontSize: 14),
        ),
        'onTap': () {},
      },
      {
        'icon': 'assets/images/icon_setting_screen/logout.png',
        'title': 'Đăng xuất',
        'trailing': Icons.arrow_forward_ios,
        'onTap': () {},
      },
    ];
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
                        image: AssetImage(
                            'assets/images/icon_home/header_home.png'),
                        fit: BoxFit.cover)),
              ),
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
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Lê Toàn Đức',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff181818),
                        fontSize: 16),
                  ),
                  const Text(
                    'Giáo viên chủ nhiệm: 1A',
                    style: TextStyle(fontSize: 13, color: Color(0xff181818)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: settingsItems.map((item) {
                        return ListTile(
                          leading: Image(image: AssetImage(item['icon'])),
                          title: Text(
                            item['title'],
                          ),
                          trailing: item['trailing'] is IconData
                              ? Icon(item['trailing'])
                              : item['trailing'],
                          onTap: item['onTap'],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: (MediaQuery.of(context).size.width - 80) / 2,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: const Image(
                    image: AssetImage('assets/images/avatar_part3.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 3),
    );
  }
}
