enum PokemonType {
  grass,
  bug,
  fire,
  water,
  electric,
  ice,
  flying,
  fighting,
  poison,
  ground,
  fairy,
  rock,
  psychic,
  dark,
  dragon,
  ghost,
  steel,
  normal,
  unknown,
}

extension PokemonTypeX on PokemonType {
  static PokemonType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'grass':
        return PokemonType.grass;
      case 'bug':
        return PokemonType.bug;
      case 'fire':
        return PokemonType.fire;
      case 'water':
        return PokemonType.water;
      case 'electric':
        return PokemonType.electric;
      case 'ice':
        return PokemonType.ice;
      case 'flying':
        return PokemonType.flying;
      case 'fighting':
        return PokemonType.fighting;
      case 'poison':
        return PokemonType.poison;
      case 'ground':
        return PokemonType.ground;
      case 'fairy':
        return PokemonType.fairy;
      case 'rock':
        return PokemonType.rock;
      case 'psychic':
        return PokemonType.psychic;
      case 'dark':
        return PokemonType.dark;
      case 'dragon':
        return PokemonType.dragon;
      case 'ghost':
        return PokemonType.ghost;
      case 'steel':
        return PokemonType.steel;
      case 'normal':
        return PokemonType.normal;
      default:
        return PokemonType.unknown;
    }
  }

  String get label {
    final name = toString().split('.').last;
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}
