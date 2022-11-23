import 'package:collectibles/bloc/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellListCubit extends Cubit<List> {
  SellListCubit() : super([]);
}

class InventoryListCubit extends Cubit<List> {
  InventoryListCubit() : super([]);

  load() {}
}
