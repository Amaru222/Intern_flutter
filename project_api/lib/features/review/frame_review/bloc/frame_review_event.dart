part of 'frame_review_bloc.dart';

@immutable
sealed class FrameReviewEvent {}

class LoadDataFrameReview extends FrameReviewEvent {
  final String studentId;

  LoadDataFrameReview(this.studentId);
}

class PostReviewButtonPressed extends FrameReviewEvent {
  final String studentId;
  final String message;

  PostReviewButtonPressed(this.studentId, this.message);
}
