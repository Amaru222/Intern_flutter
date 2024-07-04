part of 'frame_review_bloc.dart';

@immutable
sealed class FrameReviewState {}

final class FrameReviewInitial extends FrameReviewState {}

class FrameReviewLoaded extends FrameReviewState {
  final List<dynamic> listMessageReviewFilterIdStudent;

  FrameReviewLoaded({required this.listMessageReviewFilterIdStudent});
}

class FrameReviewError extends FrameReviewState {
  final String message;
  FrameReviewError(this.message);
}
