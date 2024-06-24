part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceEvent {}

class LoadStudent extends AttendanceEvent {}

class ToggleCheckbox extends AttendanceEvent {
  final int index;

  ToggleCheckbox({required this.index});
}

class SelectAllCheckbox extends AttendanceEvent {
  final bool isSelected;

  SelectAllCheckbox({required this.isSelected});

}
