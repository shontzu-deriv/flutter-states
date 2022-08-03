import 'package:flutter_bloc/flutter_bloc.dart';

class InputCubit extends Cubit<int> {
  InputCubit() : super(0);

  void setInputVal(value) {
    emit(value);
  }
}