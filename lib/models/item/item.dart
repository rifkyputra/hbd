import 'package:collectibles/bloc/buy/buy_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable
    implements
        Sellable,
        Equipable,
        Consumable,
        HasKeyId,
        HasTimestamp,
        HasStat {
  Item();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  // TODO: implement date
  DateTime get date => throw UnimplementedError();

  @override
  // TODO: implement keyId
  get keyId => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stat
  get stat => throw UnimplementedError();
}

// class Item
//     implements
//         Sellable,
//         Equipable,
//         Consumable,
//         HasKeyId,
//         HasTimestamp,
//         HasStat {
//   final int _id;

//   @override
//   final Stat stat;

//   Item(
//     this._id, {
//     required this.stat,
//   });

//   @override
//   int get keyId => _id;

//   @override
//   DateTime get date => throw UnimplementedError();
// }
