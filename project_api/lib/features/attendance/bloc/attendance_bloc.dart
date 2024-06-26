import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meta/meta.dart';
import 'package:project/firebase/attendance_repository.dart';
import 'package:project/firebase/user_repository.dart';
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
    _listenToAttendanceChange();
    on<LoadStudent>(_loadStudent);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<SelectAllCheckbox>(_selectAllCheckbox);
    on<AttendButtonPressed>(_attenButtonPresses);
    on<LeaveButtonPressed>(_leaveButtonPressed);
  }

  Future<FutureOr<void>> _loadStudent(
      LoadStudent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final currentId = await userRepository.getCurrentUserUid();
      if (currentId != null) {
        final user = await userRepository.fetchUserByUid(currentId);
        if (user != null && user.role == 0) {
          final students =
              await userRepository.fetchStudentsInClass(user.className);

          final userAttendance =
              await attendanceRepository.fetchStudentsAttendanceInClass(
                  user.className, _getCurrentFormattedDate());

          final checkboxStates = List<bool>.filled(students.length, false);
          emit(AttendanceLoaded(
              users: students,
              checkboxstates: checkboxStates,
              userAttendance: userAttendance));
        } else {
          emit(AttendanceError('ko co hs cung lop voi giao vien'));
        }
      } else {
        emit(AttendanceError('ko co user'));
      }
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  void _listenToAttendanceChange() {
    add(LoadStudent());
  }

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<AttendanceState> emit) {
    if (state is AttendanceLoaded) {
      final loadState = state as AttendanceLoaded;
      final updateCheckboxStates = List<bool>.from(loadState.checkboxstates);
      updateCheckboxStates[event.index] = !updateCheckboxStates[event.index];
      emit(AttendanceLoaded(
          users: loadState.users,
          checkboxstates: updateCheckboxStates,
          userAttendance: loadState.userAttendance));
    }
  }

  FutureOr<void> _selectAllCheckbox(
      SelectAllCheckbox event, Emitter<AttendanceState> emit) {
    if (state is AttendanceLoaded) {
      final loadState = state as AttendanceLoaded;
      final updateCheckboxStates =
          List<bool>.filled(loadState.users.length, event.isSelected);
      emit(AttendanceLoaded(
          users: loadState.users,
          checkboxstates: updateCheckboxStates,
          userAttendance: loadState.userAttendance));
    }
  }

  Future<FutureOr<void>> _attenButtonPresses(
      AttendButtonPressed event, Emitter<AttendanceState> emit) async {
    if (state is AttendanceLoaded) {
      final loadState = state as AttendanceLoaded;
      final selectedUids = <String>[];

      for (int i = 0; i < loadState.checkboxstates.length; i++) {
        if (loadState.checkboxstates[i]) {
          selectedUids.add(loadState.users[i].uid);
        }
      }
      if (selectedUids.isNotEmpty) {
        try {
          await attendanceRepository.updateUserAttendance(selectedUids,
              loadState.users[0].className, _getCurrentFormattedDate());
          add(LoadStudent());
        } catch (e) {
          emit(AttendanceError('Failed to mark attendance: $e'));
        }
      }
    }
  }

  String _getCurrentFormattedDate() {
    DateTime today = DateTime.now();
    return "${today.day}/${today.month}/${today.year}";
  }

  Future<FutureOr<void>> _leaveButtonPressed(
      LeaveButtonPressed event, Emitter<AttendanceState> emit) async {
    if (state is AttendanceLoaded) {
      final loadState = state as AttendanceLoaded;
      final selectedUids = <String>[];

      for (int i = 0; i < loadState.checkboxstates.length; i++) {
        if (loadState.checkboxstates[i]) {
          selectedUids.add(loadState.users[i].uid);
        }
      }
      if (selectedUids.isNotEmpty) {
        try {
          await attendanceRepository.updateUserLeave(selectedUids,
              loadState.users[0].className, _getCurrentFormattedDate());
          add(LoadStudent());
        } catch (e) {
          emit(AttendanceError('Failed to leave attendance: $e'));
        }
      }
    }
  }
}
