import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/apis/attendance_repository.dart';
import 'package:project/apis/user_repository.dart';
import 'package:project/model/attendance.dart';
import 'package:project/model/user.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final UserRepository userRepository;
  final AttendanceRepository attendanceRepository;
  AttendanceBloc(this.userRepository, this.attendanceRepository)
      : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    on<LoadStudent>(_loadStudent);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<SelectAllCheckbox>(_selectAllCheckbox);
    on<AttendButtonPressed>(_attenButtonPresses);
    on<LeaveButtonPressed>(_leaveButtonPressed);
  }

  Future<FutureOr<void>> _loadStudent(
      LoadStudent event, Emitter<AttendanceState> emit) async {}

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<AttendanceState> emit) {}

  FutureOr<void> _selectAllCheckbox(
      SelectAllCheckbox event, Emitter<AttendanceState> emit) {}

  Future<FutureOr<void>> _attenButtonPresses(
      AttendButtonPressed event, Emitter<AttendanceState> emit) async {}

  Future<FutureOr<void>> _leaveButtonPressed(
      LeaveButtonPressed event, Emitter<AttendanceState> emit) async {}
}
