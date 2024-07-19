part of 'frame_review_bloc.dart';

@immutable
sealed class FrameReviewEvent {}

class LoadDataFrameReview extends FrameReviewEvent {
  final String studentId;

  LoadDataFrameReview(this.studentId);
}

class LoadMoreDataFrameReview extends FrameReviewEvent {
  final String studentId;
  LoadMoreDataFrameReview(this.studentId);
}

class PostReviewButtonPressed extends FrameReviewEvent {
  final String studentId;
  final String message;
  final List<Map<String, dynamic>> listReview;
  PostReviewButtonPressed(
    this.studentId,
    this.message,
    this.listReview,
  );
}

class UpdateReviewButtonPressed extends FrameReviewEvent {
  final String studentId;
  final String message;
  final Map<String, dynamic> listReview;
  UpdateReviewButtonPressed(this.studentId, this.message, this.listReview);
}

class DeleteReviewButtonPressed extends FrameReviewEvent {
  final String studentId;
  final Map<String, dynamic> listReview;

  DeleteReviewButtonPressed(this.studentId, this.listReview);
}
