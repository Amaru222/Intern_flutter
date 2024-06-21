part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// ignore: camel_case_types
class LoadDataProfile extends ProfileEvent {}

class ProfileUpdated extends ProfileEvent {
  final List<Map<String, dynamic>> profileItems;
  final String nameUser;
  final String classInfo;
  final String title;
  const ProfileUpdated(
      this.profileItems, this.nameUser, this.classInfo, this.title);
  @override
  List<Object> get props => [profileItems, nameUser, classInfo];
}
