part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

class LoadDataReview extends ReviewEvent {}
