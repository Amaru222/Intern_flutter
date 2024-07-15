part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final Map<String, dynamic> listStudent;
  final Map<String, String> studentMessageFinal;
  final Map<String, String> dateFinalWithId;
  ReviewLoaded(
      {required this.listStudent,
      required this.studentMessageFinal,
      required this.dateFinalWithId});
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError(this.message);
}
