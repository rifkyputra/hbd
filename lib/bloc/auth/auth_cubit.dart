import 'package:flutter_bloc/flutter_bloc.dart';

class IsAuthenticatedCubit extends Cubit<bool> {
  IsAuthenticatedCubit() : super(false);

  login() => emit(true);
  logout() => emit(false);
}
