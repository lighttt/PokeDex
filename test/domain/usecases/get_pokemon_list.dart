import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';

import 'get_pokemon_list.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  MockPokemonRepository mockPokemonRepository;
  GetPokemonListUseCase usecase;
  UnmodifiableListView<PokemonEntity> tPokemonEntity;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonListUseCase(repository: mockPokemonRepository);
    tPokemonEntity = UnmodifiableListView([
      PokemonEntity(
        name: "Bulbasaur",
        id: "#001",
        imageUrl:
            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
        description:
            "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
        height: "2' 04\"",
        category: "Seed",
        weight: "15.2 lbs",
        types: ["Grass", "Poison"],
        weaknesses: ["Fire", "Flying", "Ice", "Psychic"],
        evolutions: ["#001", "#002", "#003"],
        abilities: ["Overgrow"],
        hp: 20,
        attack: 30,
        defense: 20,
        specialAttack: 30,
        specialDefense: 30,
        speed: 30,
        total: 160,
        malePercentage: "87.5%",
        femalePercentage: "12.5%",
        cycles: "20 ",
        eggGroups: "Grass, Monster ",
        evolvedFrom: "",
        baseExp: "64",
        evolveLevel: '',
      )
    ]);
  });

  test(
    'should get pokemon list from the repository',
    () async {
      //arrange
      when(mockPokemonRepository.getPokemonList())
          .thenAnswer((_) async => Right(tPokemonEntity));
      //act
      final result = await usecase.call(NoParams());
      //assert
      expect(result, equals(Right(tPokemonEntity)));
      verify(mockPokemonRepository.getPokemonList());
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
