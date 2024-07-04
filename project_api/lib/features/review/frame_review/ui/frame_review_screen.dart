import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/apis/dio_factory.dart';
import 'package:project/features/review/frame_review/bloc/frame_review_bloc.dart';
import 'package:project/services/review_service.dart';

class FrameReview extends StatefulWidget {
  final String studentId;
  const FrameReview({super.key, required this.studentId});
  @override
  State<FrameReview> createState() => _FrameReviewState();
}

class _FrameReviewState extends State<FrameReview> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dio = createDio();
    final reviewService = ReviewService(dio: dio);
    bool reserve = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
                      onPressed: () {
                        context.go('/home/review');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 26,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                      minRadius: 15,
                      maxRadius: 20,
                      backgroundImage: AssetImage('assets/images/avatar.png')),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Tran van tuan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => FrameReviewBloc(reviewService)
          ..add(LoadDataFrameReview(widget.studentId)),
        child: BlocBuilder<FrameReviewBloc, FrameReviewState>(
          builder: (context, state) {
            if (state is FrameReviewInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FrameReviewLoaded) {
              if (state.listMessageReviewFilterIdStudent.length > 9) {
                reserve = true;
              }
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                          reverse: reserve,
                          itemCount:
                              state.listMessageReviewFilterIdStudent.length,
                          itemBuilder: (context, index) {
                            return Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.height * 0.8,
                                child: listMessage(
                                    index: index,
                                    message: state
                                        .listMessageReviewFilterIdStudent));
                          }),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              autofocus: true,
                              controller: messageController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: "Send a message...",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  border: InputBorder.none),
                            )),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.send))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is FrameReviewError) {
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

  Widget listMessage({required index, required List<dynamic> message}) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(child: Text('20:10')),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 221, 221),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message[index],
                  style: const TextStyle(fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
