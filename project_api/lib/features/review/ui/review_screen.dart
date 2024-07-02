import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 26,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Nhận xét',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.search)),
              ),
            ],
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: listStudentComment(),
                );
              })
        ],
      ),
    );
  }
  Widget listStudentComment() {
    return const ListTile(
      horizontalTitleGap: 5,
      leading: CircleAvatar(
          minRadius: 20,
          maxRadius: 25,
          backgroundImage: AssetImage('assets/images/avatar.png')),
      title: Text(
        'Trần Văn Tuấn',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Text('Hôm nay bạn thế nào'),
          SizedBox(
            width: 10,
          ),
          Text('15:00'),
        ],
      ),
    );
  }
}
