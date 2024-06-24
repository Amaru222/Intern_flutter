import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:project/firebase/user_repository.dart';
import 'package:project/model/user.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final UserRepository userRepository;
  AttendanceBloc(this.userRepository) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    _listenToAttendanceChange();
    on<LoadStudent>(_loadStudent);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<SelectAllCheckbox>(_selectAllCheckbox);
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
          final checkboxStates = List<bool>.filled(students.length, false);
          emit(AttendanceLoaded(
              users: students, checkboxstates: checkboxStates));
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
          users: loadState.users, checkboxstates: updateCheckboxStates));
    }
  }

  FutureOr<void> _selectAllCheckbox(
      SelectAllCheckbox event, Emitter<AttendanceState> emit) {
    if (state is AttendanceLoaded) {
      final loadState = state as AttendanceLoaded;
      final updateCheckboxStates =
          List<bool>.filled(loadState.users.length, event.isSelected);
      emit(AttendanceLoaded(
          users: loadState.users, checkboxstates: updateCheckboxStates));
    }
  }
}
