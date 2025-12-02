class PokemonModel {
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
  bool isFavourite;

  PokemonModel({
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

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String _string(String key) => (json[key] ?? '').toString();
    int _int(String key) => int.tryParse(json[key]?.toString() ?? '') ?? 0;
    List<String> _list(String key) =>
        (json[key] as List?)?.map((value) => value.toString()).toList() ?? [];

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
}
