part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final Map<String, dynamic> listStudent;
  final List<bool> selectedCheckboxes;
  AttendanceLoaded(this.listStudent, {required this.selectedCheckboxes});
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}

class AttendanceUpdatedSuccessfully extends AttendanceState {
  AttendanceUpdatedSuccessfully();
}
