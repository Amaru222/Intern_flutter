import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:project/services/review_service.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewService reviewService;
  ReviewBloc(this.reviewService) : super(ReviewInitial()) {
    on<ReviewEvent>((event, emit) {});
    on<LoadDataReview>(_loadDataReview);
  }

  Future<FutureOr<void>> _loadDataReview(
      LoadDataReview event, Emitter<ReviewState> emit) async {
    try {
      final listReview = await reviewService.getListReView();
      final listStudent = await reviewService.getListStudent();
      final studentMessageFinal = <String, String>{};
      final dateFinalWithId = <String, String>{};
      for (var student in listStudent['data']['items']) {
        final studentId = student['id'];
        final listMessageByIdStudent = listReview['data']['items']
            .where((review) => review['studentId'] == studentId)
            .map((review) => review['message'])
            .toList();
        final lastMessage = listMessageByIdStudent.isNotEmpty
            ? listMessageByIdStudent.last
            : '';
        studentMessageFinal[studentId] = lastMessage;
        final listCreatedDateByIdStudent = listReview['data']['items']
            .where((review) => review['studentId'] == studentId)
            .map((review) => review['createdAt'])
            .toList();
        final lastCreatedAt = listCreatedDateByIdStudent.isNotEmpty
            ? listCreatedDateByIdStudent.last
            : '';
        final listUpdatedDateByIdStudent = listReview['data']['items']
            .where((review) => review['studentId'] == studentId)
            .map((review) => review['updatedAt'])
            .toList();
        final lastUpdatedAt = listUpdatedDateByIdStudent.isNotEmpty
            ? listUpdatedDateByIdStudent.last
            : '';
        
        String dateFinalFormat = formatDate(lastUpdatedAt, lastCreatedAt);
        dateFinalWithId[studentId] = dateFinalFormat;
      }
      emit(ReviewLoaded(
          listReview: listReview,
          listStudent: listStudent,
          studentMessageFinal: studentMessageFinal,
          dateFinalWithId: dateFinalWithId));
    } catch (error) {
      emit(ReviewError(error.toString()));
    }
  }

  String formatDate(String lastUpdatedAt, String lastCreatedAt) {
    DateTime now = DateTime.now();
    String dateFinalFormat;
    if (lastUpdatedAt != '' && lastCreatedAt != '') {
      DateTime lastUpdatedAts = DateTime.parse(lastUpdatedAt);
      DateTime lastCreatedAts = DateTime.parse(lastCreatedAt);
      Duration difference;
      if (lastUpdatedAt != '') {
        difference = now.difference(lastUpdatedAts);
        if (difference.inDays > 1 && difference.inDays < 365) {
          dateFinalFormat = "${lastUpdatedAts.day} thg ${lastUpdatedAts.month}";
        } else if (difference.inDays > 365) {
          dateFinalFormat =
              "${lastUpdatedAts.day} thg ${lastUpdatedAts.month}, ${lastUpdatedAts.year}";
        } else {
          dateFinalFormat = "${lastUpdatedAts.hour}:${lastUpdatedAts.minute}";
        }
        return dateFinalFormat;
      } else {
        difference = now.difference(lastCreatedAts);
        if (difference.inDays > 1 && difference.inDays < 365) {
          dateFinalFormat = "${lastCreatedAts.day} thg ${lastCreatedAts.month}";
        } else if (difference.inDays > 365) {
          dateFinalFormat =
              "${lastCreatedAts.day} thg ${lastCreatedAts.month}, ${lastCreatedAts.year}";
        } else {
          dateFinalFormat = "${lastCreatedAts.hour}:${lastCreatedAts.minute}";
        }
        return dateFinalFormat;
      }
    } else {
      return dateFinalFormat = '';
    }
  }
}
