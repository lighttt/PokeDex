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
  final  String evolvedFrom;
  final String cycles;
  final String baseExp;
  final List<String> weaknesses;
  final List<String> evolutions;
  final List<String> types;
  final List<String> abilities;
  final String evolveLevel;
  final bool isFavourite = false;

  const PokemonEntity({
    this.id,
    this.name,
    this.description,
    this.category,
    this.imageUrl,
    this.height,
    this.weight,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
    this.total,
    this.malePercentage,
    this.femalePercentage,
    this.eggGroups,
    this.evolvedFrom,
    this.cycles,
    this.baseExp,
    this.weaknesses,
    this.evolutions,
    this.types,
    this.abilities,
    this.evolveLevel,
  });

  @override
  List<Object> get props{
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
    ];
  }

  @override
  bool get stringify => true;
}
