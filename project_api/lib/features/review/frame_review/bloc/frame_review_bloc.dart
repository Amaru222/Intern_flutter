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
}
