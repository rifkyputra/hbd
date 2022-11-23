import 'package:collectibles/bloc/buy/buy_cubit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../item/item.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipment extends Equatable {
  final Item? slotRing;
  final Item? slotbracelet;
  final Item? slot1;
  final Item? slot2;
  final Item? slot3;

  const Equipment({
    @JsonKey(name: 'slotRing') this.slotRing,
    @JsonKey(name: 'slotBracelet') this.slotbracelet,
    @JsonKey(name: 'slot1') this.slot1,
    @JsonKey(name: 'slot2') this.slot2,
    @JsonKey(name: 'slot3') this.slot3,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
  Map<String, dynamic> toJson() => _$EquipmentToJson(this);

  @override
  List<Object?> get props => [];
}
