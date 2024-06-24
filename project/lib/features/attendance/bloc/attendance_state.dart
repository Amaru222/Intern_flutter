part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<User> users;
  final List<bool> checkboxstates;

  AttendanceLoaded({required this.users, required this.checkboxstates});
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}
