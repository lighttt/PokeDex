import 'package:pokedexapp/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.imageUrl,
    required super.height,
    required super.weight,
    required super.hp,
    required super.attack,
    required super.defense,
    required super.specialAttack,
    required super.specialDefense,
    required super.speed,
    required super.total,
    required super.malePercentage,
    required super.femalePercentage,
    required super.eggGroups,
    required super.evolvedFrom,
    required super.cycles,
    required super.baseExp,
    required super.weaknesses,
    required super.evolutions,
    required super.types,
    required super.abilities,
    required super.evolveLevel,
    super.isFavourite,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String _string(String key) => (json[key] ?? '').toString();
    int _int(String key) => int.tryParse(json[key]?.toString() ?? '') ?? 0;
    List<String> _list(String key) => (json[key] as List?)?.map((value) => value.toString()).toList() ?? [];

    return PokemonModel(
      id: _string('id'),
      description: _string('xdescription'),
      name: _string('name'),
      imageUrl: _string('imageurl'),
      hp: _int('hp'),
      defense: _int('defense'),
      attack: _int('attack'),
      speed: _int('speed'),
      total: _int('total'),
      specialAttack: _int('special_attack'),
      specialDefense: _int('special_defense'),
      baseExp: _string('base_exp'),
      malePercentage: _string('male_percentage'),
      femalePercentage: _string('female_percentage'),
      evolutions: _list('evolutions'),
      height: _string('height'),
      weight: _string('weight'),
      weaknesses: _list('weaknesses'),
      abilities: _list('abilities'),
      category: _string('category'),
      types: _list('typeofpokemon'),
      cycles: _string('cycles'),
      eggGroups: _string('egg_groups'),
      evolvedFrom: _string('evolvedFrom'),
      evolveLevel: _string('reason'),
    );
  }

  PokemonModel copyWith({bool? isFavourite}) {
    return PokemonModel(
      id: id,
      name: name,
      description: description,
      category: category,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
      total: total,
      malePercentage: malePercentage,
      femalePercentage: femalePercentage,
      eggGroups: eggGroups,
      evolvedFrom: evolvedFrom,
      cycles: cycles,
      baseExp: baseExp,
      weaknesses: weaknesses,
      evolutions: evolutions,
      types: types,
      abilities: abilities,
      evolveLevel: evolveLevel,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
