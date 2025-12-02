import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final String height;
  final String weight;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final int total;
  final String malePercentage;
  final String femalePercentage;
  final String eggGroups;
  final String evolvedFrom;
  final String cycles;
  final String baseExp;
  final List<String> weaknesses;
  final List<String> evolutions;
  final List<String> types;
  final List<String> abilities;
  final String evolveLevel;
  final bool isFavourite;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.total,
    required this.malePercentage,
    required this.femalePercentage,
    required this.eggGroups,
    required this.evolvedFrom,
    required this.cycles,
    required this.baseExp,
    required this.weaknesses,
    required this.evolutions,
    required this.types,
    required this.abilities,
    required this.evolveLevel,
    this.isFavourite = false,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      category,
      imageUrl,
      height,
      weight,
      hp,
      attack,
      defense,
      specialAttack,
      specialDefense,
      speed,
      total,
      malePercentage,
      femalePercentage,
      eggGroups,
      evolvedFrom,
      cycles,
      baseExp,
      weaknesses,
      evolutions,
      types,
      abilities,
      evolveLevel,
      isFavourite,
    ];
  }

  @override
  bool get stringify => true;
}
