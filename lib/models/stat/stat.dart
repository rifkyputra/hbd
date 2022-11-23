import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stat.g.dart';

@JsonSerializable()
class Stat extends Equatable {
  final double hunger;
  final double power;
  final double prestige;
  final double esteem;

  const Stat({
    this.hunger = 0,
    this.power = 0,
    this.prestige = 0,
    this.esteem = 0,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);

  @override
  List<Object?> get props => [];
}
