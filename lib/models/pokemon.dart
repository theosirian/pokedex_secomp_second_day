import 'package:flutter/foundation.dart';

class PokemonModel {
  final int id;
  final String name;
  final String sprite;
  final List<String> types;
  final double weight;
  final double height;

  PokemonModel({
    @required this.id,
    @required this.name,
    @required this.sprite,
    @required this.types,
    @required this.weight,
    @required this.height,
  });

  factory PokemonModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      PokemonModel(
        id: json['id'],
        name: json['name'],
        sprite: json['sprites']['front_default'],
        types: json['types']
            .map<String>((t) => t['type']['name'] as String)
            .toList(),
        weight: json['weight'] / 10.0,
        height: json['height'] * 10.0,
      );
}
