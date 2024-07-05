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
  }

  Future<FutureOr<void>> _loadDataFrameReview(
      LoadDataFrameReview event, Emitter<FrameReviewState> emit) async {
    try {
      final listMessageReview = await reviewService.getListReView();
      final listMessageByIdStudent = listMessageReview['data']['items']
          .where((review) => review['studentId'] == event.studentId)
          .map((review) => review['message'])
          .toList();
      print(listMessageByIdStudent);
      emit(FrameReviewLoaded(
          listMessageReviewFilterIdStudent: listMessageByIdStudent));
    } catch (error) {
      emit(FrameReviewError(error.toString()));
    }
  }

  Future<FutureOr<void>> _postReviewButtonPressed(
      PostReviewButtonPressed event, Emitter<FrameReviewState> emit) async {
    if (state is FrameReviewLoaded) {
      final listMessageReview = await reviewService.getListReView();
      final listReviewByIdStudent = listMessageReview['data']['items']
          .where((review) => review['studentId'] == event.studentId)
          .toList();
      final classId = listReviewByIdStudent[0]['student']['currentClassId'];
      final schoolLevel = listReviewByIdStudent[0]['schoolLevel'];
      final teacherId = listReviewByIdStudent[0]['teacherId'];
      if (event.message != '') {
        await reviewService.postCreateReView(
            event.message, classId, schoolLevel, event.studentId, teacherId);
        final updatedListMessageReview = await reviewService.getListReView();
        final updatedListMessageByIdStudent = updatedListMessageReview['data']
                ['items']
            .where((review) => review['studentId'] == event.studentId)
            .map((review) => review['message'])
            .toList();
        final updatedList = updatedListMessageByIdStudent;
        print(updatedList);
        emit(FrameReviewLoaded(listMessageReviewFilterIdStudent: updatedList));
      }
    }
  }
}
