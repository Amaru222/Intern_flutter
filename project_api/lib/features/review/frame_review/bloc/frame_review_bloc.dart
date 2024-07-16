// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/services/review_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'frame_review_event.dart';
part 'frame_review_state.dart';

class FrameReviewBloc extends Bloc<FrameReviewEvent, FrameReviewState> {
  final ReviewService reviewService;
  FrameReviewBloc(this.reviewService) : super(FrameReviewInitial()) {
    on<FrameReviewEvent>((event, emit) {});
    on<LoadDataFrameReview>(_loadDataFrameReview);
    on<PostReviewButtonPressed>(_postReviewButtonPressed);
    on<UpdateReviewButtonPressed>(_updateReviewButtonPressed);
    on<DeleteReviewButtonPressed>(_deleteReviewButtonPressed);
  }
  Future<FutureOr<void>> _loadDataFrameReview(
      LoadDataFrameReview event, Emitter<FrameReviewState> emit) async {
    try {
      loadDataListReview(event.studentId);
    } catch (error) {
      emit(FrameReviewError(error.toString()));
    }
  }

  Future<FutureOr<void>> _postReviewButtonPressed(
      PostReviewButtonPressed event, Emitter<FrameReviewState> emit) async {
    if (state is FrameReviewLoaded) {
      if (event.message != '') {
        await reviewService.postCreateReView(
            message: event.message,
            classId: event.listReview[0]['classId'],
            schoolLevel: event.listReview[0]['schoolLevel'],
            studentId: event.studentId,
            teacherId: event.listReview[0]['teacherId']);
        // listReview(event.studentId);
        updateDataListReview(event.studentId);
      }
    }
  }

  Future<FutureOr<void>> _updateReviewButtonPressed(
      UpdateReviewButtonPressed event, Emitter<FrameReviewState> emit) async {
    if (state is FrameReviewLoaded) {
      if (event.message != '') {
        await reviewService.patchUpdateReview(
          messageId: event.listReview['messageId'],
          message: event.message,
          classId: event.listReview['classId'],
          schoolLevel: event.listReview['schoolLevel'],
          studentId: event.studentId,
          teacherId: event.listReview['teacherId'],
        );
        // listReview(event.studentId);
        updateDataListReview(event.studentId);
      }
    }
  }

  Future<FutureOr<void>> _deleteReviewButtonPressed(
      DeleteReviewButtonPressed event, Emitter<FrameReviewState> emit) async {
    try {
      if (event.listReview['messageId'] != '') {
        String messageId = event.listReview['messageId'];
        await reviewService.deleteReview(messageId: messageId);
      }
      // listReview(event.studentId);
      updateDataListReview(event.studentId);
    } catch (error) {
      emit(FrameReviewError(error.toString()));
    }
  }

  Future<void> loadDataListReview(
    String studentId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('reviewData');
    if (cachedData != null) {
      final reviewData = jsonDecode(cachedData);
      for (var listReviews in reviewData['listReview']) {
        if (listReviews['data']['filter']['studentId'] == studentId) {
          emitFrameReview(reviewData['listStudent'], listReviews, studentId);
        }
      }
    } else {
      final listReviews = await reviewService.getListReViewAll(studentId);
      final listStudent = await reviewService.getListStudent();
      emitFrameReview(listStudent, listReviews, studentId);
    }
  }

  Future<void> updateDataListReview(String studentId) async {
    final listReviews = await reviewService.getListReViewAll(studentId);
    final listStudent = await reviewService.getListStudent();
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('reviewData');

    if (cachedData != null) {
      final reviewData = jsonDecode(cachedData);

      for (var i = 0; i < reviewData['listReview'].length; i++) {
        if (reviewData['listReview'][i]['data']['filter']['studentId'] ==
            studentId) {
          reviewData['listReview'][i] = listReviews;
          break;
        }
      }
      final reviewDatas = {
        'listStudent': listStudent,
        'listReview': reviewData['listReview'],
      };
      prefs.setString('reviewData', jsonEncode(reviewDatas));
      emitFrameReview(listStudent, listReviews, studentId);
    } else {
      print("No cached data found");
    }
  }

  void emitFrameReview(Map<String, dynamic> listStudent,
      Map<String, dynamic> listReviews, String studentId) {
    final student = listStudent['data']['items'].firstWhere(
        (student) => student['id'] == studentId,
        orElse: () => null);
    if (student == null) {
      print("Student not found");
      return;
    }
    final String nameStudent = student['name'];
    final List<dynamic> updatedListMessageByIdStudent =
        listReviews['data']['items'].toList();
    final List<Map<String, dynamic>> listReview = updatedListMessageByIdStudent
        .where((review) => review['message'] != null)
        .map((review) {
      final classId = review['student']['currentClassId'];
      final schoolLevel = review['schoolLevel'];
      final teacherId = review['teacherId'];
      final message = review['message'];
      final messageId = review['id'];
      final createdAt = review['createdAt'];
      // final updatedAt = review['updatedAt'];
      final createdDate = formatTimeCreated(createdAt);
      return {
        'classId': classId,
        'schoolLevel': schoolLevel,
        'teacherId': teacherId,
        'message': message,
        'messageId': messageId,
        'nameStudent': nameStudent,
        'createdTime': createdDate,
        // 'updatedDate': updatedDate
      };
    }).toList();
    if (listReview.isEmpty) {
      listReview.add({'nameStudent': nameStudent});
    }
    emit(FrameReviewLoaded(listReview: listReview));
  }

  String formatTimeCreated(String createdAt) {
    DateTime now = DateTime.now();
    String timeFinalFormat;
    DateTime lastCreatedAts = DateTime.parse(createdAt);
    Duration difference;
    if (createdAt != '') {
      difference = now.difference(lastCreatedAts);
      String formattedHour = lastCreatedAts.hour.toString().padLeft(2, '0');
      String formattedMinute = lastCreatedAts.minute.toString().padLeft(2, '0');
      if (difference.inDays > 1 && difference.inDays < 365) {
        timeFinalFormat =
            "$formattedHour:$formattedMinute ${lastCreatedAts.day} THG ${lastCreatedAts.month}";
      } else if (difference.inDays > 365) {
        timeFinalFormat =
            "$formattedHour:$formattedMinute ${lastCreatedAts.day} THG ${lastCreatedAts.month}, ${lastCreatedAts.year}";
      } else {
        timeFinalFormat = "${lastCreatedAts.hour}:${lastCreatedAts.minute}";
      }
      return timeFinalFormat;
    } else {
      return timeFinalFormat = '';
    }
  }
}
