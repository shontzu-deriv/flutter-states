import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateCubit extends Cubit<int> {
  CalculateCubit() : super(0);

  void multiply() {
    emit(state * 1); //todo: 1 should be replaced by input val
  }

  void divide() {
    emit(state ~/ 1); //todo: 1 should be replaced by input val
  }
}
