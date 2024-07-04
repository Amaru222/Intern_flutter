import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/apis/dio_factory.dart';
import 'package:project/features/review/bloc/review_bloc.dart';
import 'package:project/services/review_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final dio = createDio();
    final reviewService = ReviewService(dio: dio);
    return Scaffold(
      body: BlocProvider(
        create: (context) => ReviewBloc(reviewService)..add(LoadDataReview()),
        child: BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
          if (state is ReviewInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReviewLoaded) {
            return Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
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
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.listStudent['data']['items'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: listStudentComment(
                                index: index,
                                listReview: state.listReview,
                                listStudent: state.listStudent,
                                studentMessageFinal: state.studentMessageFinal,
                                dateMessageFinal: state.dateFinalWithId),
                          );
                        }),
                  )
                ],
              ),
            );
          } else if (state is ReviewError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('loi'),
            );
          }
        }),
      ),
    );
  }

  Widget listStudentComment(
      {required int index,
      required Map<String, dynamic> listReview,
      required Map<String, dynamic> listStudent,
      required Map<String, String> studentMessageFinal,
      required Map<String, dynamic> dateMessageFinal}) {
    final nameStudent = listStudent['data']['items'][index]['name'];
    final studentId = listStudent['data']['items'][index]['id'];
    final finalMessage = studentMessageFinal[studentId] ?? '';
    final finalDate = dateMessageFinal[studentId] ?? '';
    return ListTile(
      horizontalTitleGap: 5,
      leading: const CircleAvatar(
          minRadius: 20,
          maxRadius: 25,
          backgroundImage: AssetImage('assets/images/avatar.png')),
      title: Text(
        nameStudent,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Text(finalMessage),
          const SizedBox(
            width: 10,
          ),
          Text(finalDate),
        ],
      ),
      onTap: () {
        context.go('/home/review/frameReview/$studentId');
      },
    );
  }
}
