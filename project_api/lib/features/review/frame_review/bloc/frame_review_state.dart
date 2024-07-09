part of 'frame_review_bloc.dart';

@immutable
sealed class FrameReviewState {}

final class FrameReviewInitial extends FrameReviewState {}

// ignore: must_be_immutable
class FrameReviewLoaded extends FrameReviewState {
  List<Map<String, dynamic>> listReview;

  FrameReviewLoaded({required this.listReview});
}

class FrameReviewError extends FrameReviewState {
  final String message;
  FrameReviewError(this.message);
}
