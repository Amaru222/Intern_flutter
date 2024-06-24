part of 'profile_bloc.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<Map<String, dynamic>> profileItems;
  final String nameUser;
  final String classInfo;
  final String title;

  const ProfileLoaded(
      this.profileItems, this.nameUser, this.classInfo, this.title);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
