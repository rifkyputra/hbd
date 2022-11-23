import 'package:collectibles/bloc/action_state.dart';
import 'package:collectibles/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Sort {
  byDate,
  alphabetical,
}

abstract class Sellable {}

abstract class Equipable {}

abstract class Consumable {}

abstract class HasKeyId<T> {
  final T keyId;

  HasKeyId(this.keyId);
}

abstract class HasTimestamp {
  final DateTime date;

  HasTimestamp(this.date);
}

abstract class ValueActivable<T> {
  int get activeIndex;
  List<T> get values;
  int get maxIndex => values.length - 1;
  int get minIndex => 0;
}

abstract class HasStat {
  Stat get stat;
}

class NavMenus extends ValueActivable<String> {
  @override
  final int activeIndex;

  @override
  final List<String> values;

  NavMenus(this.activeIndex, this.values);
}

class NavMenuCubit extends Cubit<NavMenus> {
  NavMenuCubit(super.initialState);

  increase() {
    if (state.activeIndex >= state.maxIndex) {
      emit(NavMenus(state.minIndex, state.values));
    } else {
      emit(NavMenus(state.activeIndex + 1, state.values));
    }
  }

  decrease() {
    if (state.activeIndex <= 0) {
      emit(NavMenus(state.maxIndex, state.values));
    } else {
      emit(NavMenus(state.activeIndex - 1, state.values));
    }
  }

  change(int index) {
    if (state.activeIndex < 0 || state.activeIndex > state.maxIndex) {
      return;
    }

    emit(NavMenus(index, state.values));
  }
}

class CubitList<T extends HasKeyId> extends Cubit<List<T>> {
  CubitList({List<T>? initial}) : super(initial ?? []);

  void assign(List<T> items) => emit(items);

  void add(T item) => emit([...state, item]);

  void replace(T replaceWith) => emit([
        for (T e in state) e.keyId == replaceWith.keyId ? replaceWith : e,
      ]);

  void remove(T replaceWith) {
    final result = List<T>.from(state)
      ..removeWhere((e) => e.keyId == replaceWith.keyId);

    emit(result);
  }
}

/// Shop Data State of an NPC
class NPCShopDisplayStateCubit extends CubitList<Item> {}

/// user action of buying item from npcs
class UserBuyNPCShopActCubit extends Cubit<ActionState> {
  UserBuyNPCShopActCubit(super.initialState);

  buy(Item item) {}
}

/// user action of selling item to npcs
class UserSellNPCShopActCubit extends Cubit<ActionState> {
  UserSellNPCShopActCubit(super.initialState);

  sell(Item item) {}
}

/// Inventory Data State
class InventoryStateCubit extends CubitList<Item> {}

/// Action in Inventory
class InventoryActCubit extends Cubit<ActionState> {
  InventoryActCubit(super.initialState);
  discard(Item item) {}
}

class CharacterCreationStateCubit extends Cubit<Character> {
  CharacterCreationStateCubit(super.initialState);
  update(Character char) => emit(char);
}

// class CharacterCreationActCubit extends Cubit<ActionState> {
//   void addName(String name, Character character) {
//     emit(character.);
//   }
// }
