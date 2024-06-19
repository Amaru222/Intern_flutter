import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileItems = [
      {
        'field': 'Ngày sinh',
        'data': '15/11/2002',
        'onTap': () {},
      },
      {
        'field': 'Email',
        'data': 'letoanduc22@gmail.com',
        'onTap': () {},
      },
      {
        'field': 'Số điện thoại',
        'data': '0002112313',
        'onTap': () {},
      },
      {
        'field': 'Địa chỉ',
        'data': 'Nam Từ Liêm, Hà Nội',
        'onTap': () {},
      },
    ];
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
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      context.go('/setting');
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  'Thông tin chi tiết',
                  style: TextStyle(
                      color: Color(0xff141416),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/avatar.png'),
                      fit: BoxFit.fill,
                      height: 60,
                      width: 60,
                    ),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff181818)),
                        ),
                        Text(
                          'Giáo viên chủ nhiệm: 1A',
                          style:
                              TextStyle(color: Color(0xff181818), fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(color: Color(0xfff7f7f7)),
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: profileItems.map((item) {
                        return ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          leading: Text(
                            item['field'],
                            style: const TextStyle(
                                color: Color(0xff6b6b6b),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Text(
                            item['data'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          onTap: item['onTap'],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
