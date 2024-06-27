part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

// ignore: camel_case_types
class LoadDataProfile extends ProfileEvent {}
