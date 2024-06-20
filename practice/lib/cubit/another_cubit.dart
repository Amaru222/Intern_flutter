import 'package:bloc/bloc.dart';

class AnotherCubit extends Cubit<int> {
  AnotherCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
