import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';

class PokemonUtils {
  static Color getColor(PokemonModel pokemon) {
    if (pokemon.types.contains('Grass') || pokemon.types.contains('Bug')) {
      return Colors.lightGreen.shade600;
    } else if (pokemon.types.contains('Fire')) {
      return Colors.redAccent;
    } else if (pokemon.types.contains('Water')) {
      return Colors.lightBlue.shade300;
    } else if (pokemon.types.contains('Electric')) {
      return Colors.yellow.shade700;
    } else if (pokemon.types.contains('Ice')) {
      return Colors.cyan.shade300;
    } else if (pokemon.types.contains('Flying')) {
      return Colors.purpleAccent;
    } else if (pokemon.types.contains('Fighting')) {
      return Colors.red.shade700;
    } else if (pokemon.types.contains('Poison')) {
      return Colors.deepPurple;
    } else if (pokemon.types.contains('Ground')) {
      return Colors.brown.shade200;
    } else if (pokemon.types.contains('Fairy')) {
      return Colors.pink.shade200;
    } else {
      return Colors.blueGrey.shade400;
    }
  }

  static Color getColorType(String type) {
    if (type == 'Grass' || type == 'Bug') {
      return Colors.lightGreen.shade600;
    } else if (type == 'Fire') {
      return Colors.redAccent;
    } else if (type == 'Water') {
      return Colors.lightBlue.shade300;
    } else if (type == 'Electric') {
      return Colors.yellow.shade700;
    } else if (type == 'Ice') {
      return Colors.cyan.shade300;
    } else if (type == 'Flying') {
      return Colors.purpleAccent;
    } else if (type == 'Fighting') {
      return Colors.red.shade700;
    } else if (type == 'Poison') {
      return Colors.deepPurple;
    } else if (type == 'Ground') {
      return Colors.brown.shade200;
    } else if (type == 'Fairy') {
      return Colors.pink.shade200;
    } else {
      return Colors.blueGrey.shade400;
    }
  }
}
