part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// ignore: camel_case_types
class LoadDataProfile extends ProfileEvent {}
