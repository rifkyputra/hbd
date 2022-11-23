import 'package:flutter_bloc/flutter_bloc.dart';

class OnboadingCubit extends Cubit<bool> {
  OnboadingCubit() : super(false);

  check() => emit(false);
}
