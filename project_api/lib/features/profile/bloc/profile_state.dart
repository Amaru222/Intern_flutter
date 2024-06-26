part of 'profile_bloc.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userProfile;

  ProfileLoaded(this.userProfile);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
