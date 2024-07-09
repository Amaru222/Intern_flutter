import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/services/review_service.dart';

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
      listReview(event.studentId);
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
        listReview(event.studentId);
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
        listReview(event.studentId);
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
    } catch (error) {
      emit(FrameReviewError(error.toString()));
    }
  }

  Future<void> listReview(
    String studentId,
  ) async {
    final listReviews = await reviewService.getListReView();
    final List<dynamic> updatedListMessageByIdStudent = listReviews['data']
            ['items']
        .where((review) => review['studentId'] == studentId)
        .toList();
    final List<Map<String, dynamic>> listReview =
        updatedListMessageByIdStudent.map((review) {
      final classId = review['student']['currentClassId'];
      final schoolLevel = review['schoolLevel'];
      final teacherId = review['teacherId'];
      final message = review['message'];
      final messageId = review['id'];
      return {
        'classId': classId,
        'schoolLevel': schoolLevel,
        'teacherId': teacherId,
        'message': message,
        'messageId': messageId
      };
    }).toList();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(FrameReviewLoaded(listReview: listReview));
  }
}
