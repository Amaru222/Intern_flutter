import 'dart:ui';

import 'package:flutter/material.dart';
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
    return BlocProvider(
      create: (context) => FrameReviewBloc(reviewService)
        ..add(LoadDataFrameReview(
          widget.studentId,
        )),
      child: Scaffold(
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
                        backgroundImage:
                            AssetImage('assets/images/avatar.png')),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Tran van tuan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: BlocBuilder<FrameReviewBloc, FrameReviewState>(
          builder: (context, state) {
            if (state is FrameReviewInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FrameReviewLoaded) {
              if (state.listReview.length > 4) {
                reserve = true;
              }
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                          reverse: reserve,
                          itemCount: state.listReview.length,
                          itemBuilder: (context, index) {
                            return Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.height * 0.8,
                                child: listMessage(
                                    index: index,
                                    listReviews: state.listReview,
                                    context: context, // Pass the context
                                    frameReviewBloc: context.read<
                                        FrameReviewBloc>() // Pass the Bloc to listMessage
                                    ));
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
                                onPressed: () {
                                  context
                                      .read<FrameReviewBloc>()
                                      .add(PostReviewButtonPressed(
                                        widget.studentId,
                                        messageController.text,
                                        state.listReview,
                                      ));
                                  messageController.clear();
                                },
                                icon: const Icon(Icons.send))
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
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget listMessage(
      {required int index,
      required List<Map<String, dynamic>> listReviews,
      required BuildContext context,
      required FrameReviewBloc frameReviewBloc}) {
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
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: frameReviewBloc,
                      child: showBottomSheet(listReviews[index],
                          frameReviewBloc), // Pass the Bloc to showBottomSheet
                    );
                  });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 221, 221),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    listReviews[index]['message'],
                    style: const TextStyle(fontSize: 20),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget showBottomSheet(
      Map<String, dynamic> listReview, FrameReviewBloc frameReviewBloc) {
    return BlocBuilder<FrameReviewBloc, FrameReviewState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .015,
                  horizontal: MediaQuery.of(context).size.width * .4),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            iconOption(context, 'Text copy', const Icon(Icons.copy_all_rounded),
                () {}),
            Divider(
              color: Colors.black54,
              endIndent: MediaQuery.of(context).size.width * .04,
              indent: MediaQuery.of(context).size.width * .04,
            ),
            iconOption(
                context, 'Edit message', const Icon(Icons.copy_all_rounded),
                () {
              _showMessageUpdateDialog(context, listReview['message'],
                  (message) {
                context.read<FrameReviewBloc>().add(UpdateReviewButtonPressed(
                    widget.studentId, message, listReview));
              });
            }),
            iconOption(
                context, 'Delete message', const Icon(Icons.copy_all_rounded),
                () {
              context
                  .read<FrameReviewBloc>()
                  .add(DeleteReviewButtonPressed(listReview));
            }),
          ],
        );
      },
    );
  }
}

void _showMessageUpdateDialog(
    BuildContext context, String message, ValueChanged<String> onPressed) {
  TextEditingController messageController =
      TextEditingController(text: message);
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding:
                const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [],
            ),
            content: TextFormField(
              controller: messageController,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed(messageController.text);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ))
            ],
          ));
}

Widget iconOption(
    BuildContext context, String name, Icon icon, VoidCallback onTap) {
  return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .05,
            top: MediaQuery.of(context).size.height * .015,
            bottom: MediaQuery.of(context).size.height * .015),
        child: Row(children: [
          icon,
          Flexible(
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 15, color: Colors.black54, letterSpacing: 0.5)))
        ]),
      ));
}
