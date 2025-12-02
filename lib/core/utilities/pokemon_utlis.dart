import 'package:flutter/material.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/entities/pokemon_type.dart';

class PokemonUtils {
  static Color getColor(PokemonEntity pokemon) {
    return pokemon.types.map(getColorType).firstOrNull ?? Colors.blueGrey.shade400;
  }

  static Color getColorType(PokemonType type) {
    switch (type) {
      case PokemonType.grass:
      case PokemonType.bug:
        return Colors.lightGreen.shade600;
      case PokemonType.fire:
        return Colors.redAccent;
      case PokemonType.water:
        return Colors.lightBlue.shade300;
      case PokemonType.electric:
        return Colors.yellow.shade700;
      case PokemonType.ice:
        return Colors.cyan.shade300;
      case PokemonType.flying:
        return Colors.purpleAccent;
      case PokemonType.fighting:
        return Colors.red.shade700;
      case PokemonType.poison:
        return Colors.deepPurple;
      case PokemonType.ground:
        return Colors.brown.shade200;
      case PokemonType.fairy:
        return Colors.pink.shade200;
      case PokemonType.rock:
        return Colors.orange.shade700;
      case PokemonType.psychic:
        return Colors.pink.shade400;
      case PokemonType.dark:
        return Colors.brown.shade700;
      case PokemonType.dragon:
        return Colors.indigo;
      case PokemonType.ghost:
        return Colors.deepPurple.shade700;
      case PokemonType.steel:
        return Colors.blueGrey;
      case PokemonType.normal:
        return Colors.grey;
      case PokemonType.unknown:
        return Colors.blueGrey.shade400;
    }
  }
}
