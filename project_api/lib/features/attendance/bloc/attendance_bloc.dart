// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:project/services/attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceService attendanceService;
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  AttendanceBloc(this.attendanceService) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    on<LoadStudent>(_loadStudent);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<SelectAllCheckbox>(_selectAllCheckbox);
    on<AttendButtonPressed>(_attenButtonPressed);
    on<LeaveButtonPressed>(_leaveButtonPressed);
    on<ChangeDate>(_changeDate);
  }
  Future<FutureOr<void>> _loadStudent(
      LoadStudent event, Emitter<AttendanceState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('attendanceData');
      if (cachedData != null) {
        final attendanceData = jsonDecode(cachedData);
        final List<bool> selectedCheckboxes = List.filled(
            attendanceData['listStudent']['data']['items'].length, false);
        emit(AttendanceLoaded(attendanceData['listStudent'],
            selectedCheckboxes: selectedCheckboxes));
      } else {
        emitLoadAttendance();
      }
    } catch (error) {
      emit(AttendanceError(error.toString()));
    }
  }

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<AttendanceState> emit) {
    if (state is AttendanceLoaded) {
      final currentState = state as AttendanceLoaded;
      final List<bool> updatedCheckboxes =
          List.from(currentState.selectedCheckboxes);
      updatedCheckboxes[event.index] = !updatedCheckboxes[event.index];
      emit(AttendanceLoaded(currentState.listStudent,
          selectedCheckboxes: updatedCheckboxes));
    }
  }

  FutureOr<void> _selectAllCheckbox(
      SelectAllCheckbox event, Emitter<AttendanceState> emit) {
    if (state is AttendanceLoaded) {
      final currentState = state as AttendanceLoaded;
      final List<bool> updatedCheckboxes =
          List.filled(currentState.selectedCheckboxes.length, event.isSelected);
      emit(AttendanceLoaded(currentState.listStudent,
          selectedCheckboxes: updatedCheckboxes));
    }
  }

  Future<FutureOr<void>> _attenButtonPressed(
      AttendButtonPressed event, Emitter<AttendanceState> emit) async {
    if (state is AttendanceLoaded) {
      final currentState = state as AttendanceLoaded;
      final selectedStudentIds = <String>[];
      for (int i = 0; i < currentState.selectedCheckboxes.length; i++) {
        if (currentState.selectedCheckboxes[i]) {
          selectedStudentIds
              .add(currentState.listStudent['data']['items'][i]['id']);
        }
      }
      await attendanceService.postCheckIn(selectedStudentIds);
      emitLoadAttendance();
    }
  }

  Future<FutureOr<void>> _leaveButtonPressed(
      LeaveButtonPressed event, Emitter<AttendanceState> emit) async {
    if (state is AttendanceLoaded) {
      final currentState = state as AttendanceLoaded;

      final selectedStudentIds = <String>[];
      for (int i = 0; i < currentState.selectedCheckboxes.length; i++) {
        if (currentState.selectedCheckboxes[i]) {
          selectedStudentIds
              .add(currentState.listStudent['data']['items'][i]['id']);
        }
      }
      await attendanceService.postCheckOut(selectedStudentIds);
      emitLoadAttendance();
    }
  }

  Future<void> emitLoadAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    final listStudent =
        await attendanceService.getListStudentAttendanceDate(_selectedDate);
    final List<bool> selectedCheckboxes =
        List.filled(listStudent['data']['items'].length, false);
    final attendanceData = {
      'listStudent': listStudent,
    };
    prefs.setString('attendanceData', jsonEncode(attendanceData));
    emit(AttendanceLoaded(listStudent, selectedCheckboxes: selectedCheckboxes));
  }

  Future<FutureOr<void>> _changeDate(
      ChangeDate event, Emitter<AttendanceState> emit) async {
    _selectedDate = event.date;
    final listStudent =
        await attendanceService.getListStudentAttendanceDate(_selectedDate);
    final List<bool> selectedCheckboxes =
        List.filled(listStudent['data']['items'].length, false);
    emit(AttendanceLoaded(listStudent, selectedCheckboxes: selectedCheckboxes));
  }
}
