import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/apis/dio_factory.dart';
import 'package:project/model/user.dart';
import 'package:project/services/user_info.dart';
import 'package:project/features/profile/bloc/profile_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final dio = createDio();
    final userInfoGetApi = UserInfoGetApi(dio: dio);
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ProfileBloc(userInfoGetApi: userInfoGetApi)..add(LoadDataProfile()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              return builProfileUI(state.userProfile);
            } else if (state is ProfileError) {
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
    );
  }

  Widget builProfileUI(User userProfile) {
    // String nameUser = userProfile['data']['record']['name'] ?? '';
    // String role = userProfile['data']['record']['roleInfo']['role'] ?? '';
    // String nameRole = '';
    // if (role == 'teacher') {
    //   nameRole = userProfile['data']['record']['teacher']['name'] ?? '';
    // } else {
    //   nameRole = userProfile['data']['record']['parents']['name'] ?? '';
    // }
    // String classInfo =
    //     userProfile['data']['record']['teacher']['class']['name'] ?? '';
    List<Map<String, dynamic>> profileItems = [
      {
        'field': 'Ngày sinh',
        'data': '15/11/1999',
        'onTap': () {},
      },
      {
        'field': 'Email',
        'data': userProfile.email,
        'onTap': () {},
      },
      {
        'field': 'Số điện thoại',
        'data': userProfile.phone,
        'onTap': () {},
      },
      {
        'field': 'Địa chỉ',
        'data': '',
        'onTap': () {},
      },
    ];
    return Container(
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
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Image(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                  ),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff181818)),
                      ),
                      Text(
                        '${userProfile.nameRole} : ${userProfile.classInfo}',
                        style: const TextStyle(
                            color: Color(0xff181818), fontSize: 13),
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
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final item = profileItems[index];
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
