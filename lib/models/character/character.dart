import 'package:collectibles/models/stat/stat.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final String name;
  final Stat stat;

  Character({
    required this.name,
    @JsonKey(name: 'stat') required this.stat,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  @override
  List<Object?> get props => [];
}
