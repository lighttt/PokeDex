import 'package:pokedexapp/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  String id;
  String name;
  String description;
  String category;
  String imageUrl;
  String height;
  String weight;
  int hp;
  int attack;
  int defense;
  int specialAttack;
  int specialDefense;
  int speed;
  int total;
  String malePercentage;
  String femalePercentage;
  String eggGroups;
  String evolvedFrom;
  String cycles;
  String baseExp;
  List<String> weaknesses;
  List<String> evolutions;
  List<String> types;
  List<String> abilities;
  String evolveLevel;
  bool isFavourite = false;

  PokemonModel({
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
    this.isFavourite = false,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
        id: json['id'],
        description: json['xdescription'],
        name: json['name'],
        imageUrl: json['imageurl'],
        hp: int.tryParse(json['hp'].toString()),
        defense: int.tryParse(json['defense'].toString()),
        attack: int.tryParse(json['attack'].toString()),
        speed: int.tryParse(json['speed'].toString()),
        total: int.tryParse(json['total'].toString()),
        specialAttack: int.tryParse(json['special_attack'].toString()),
        specialDefense: int.tryParse(json['special_defense'].toString()),
        baseExp: json['base_exp'],
        malePercentage: json['male_percentage'],
        femalePercentage: json['female_percentage'],
        evolutions: json['evolutions']?.cast<String>(),
        height: json['height'],
        weight: json['weight'],
        weaknesses: json['weaknesses']?.cast<String>(),
        abilities: json['abilities']?.cast<String>(),
        category: json['category'],
        types: json['typeofpokemon']?.cast<String>(),
        cycles: json['cycles'],
        eggGroups: json['egg_groups'],
        evolvedFrom: json['evolvedFrom'],
        evolveLevel: json['reason']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['imageurl'] = this.imageUrl;
    data['xdescription'] = this.description;
    data['height'] = this.height;
    data['category'] = this.category;
    data['weight'] = this.weight;
    data['typeofpokemon'] = this.types;
    data['weaknesses'] = this.weaknesses;
    data['evolutions'] = this.evolutions;
    data['abilities'] = this.abilities;
    data['hp'] = this.hp;
    data['attack'] = this.attack;
    data['defense'] = this.defense;
    data['special_attack'] = this.specialAttack;
    data['special_defense'] = this.specialDefense;
    data['speed'] = this.speed;
    data['total'] = this.total;
    data['male_percentage'] = this.malePercentage;
    data['female_percentage'] = this.femalePercentage;
    data['cycles'] = this.cycles;
    data['egg_groups'] = this.eggGroups;
    data['base_exp'] = this.baseExp;
    return data;
  }
}
