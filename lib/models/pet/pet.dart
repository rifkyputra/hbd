import 'package:collectibles/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  final String name;
  final Stat stat;

  Pet({
    required this.name,
    required this.stat,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
  Map<String, dynamic> toJson() => _$PetToJson(this);
}
