import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';

class Pokemon {
  final PokemonDetailResponse pokemonDetails;

  final String? types;

  final num? averagePower;

  final Color? bgColor;

  final String? bmi;

  Pokemon(
      {required this.pokemonDetails,
      required this.types,
      required this.averagePower,
      required this.bgColor,
      required this.bmi});

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      types: json['types'],
      pokemonDetails: PokemonDetailResponse.fromJson(
          Map<String, dynamic>.from(json['pokemonDetails'])),
      averagePower: json['averagePower'],
      bmi: json['bmi'],
      bgColor: Color(json['bgColor']));

  Map<String, dynamic> toJson() => {
        'types': types,
        'pokemonDetails': pokemonDetails.toJson(),
        'averagePower': averagePower,
        'bmi': bmi,
        'bgColor': bgColor?.value
      };
}
