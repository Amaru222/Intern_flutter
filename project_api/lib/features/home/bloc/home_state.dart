part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final User userProfile;

  const HomeLoaded(this.userProfile);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
