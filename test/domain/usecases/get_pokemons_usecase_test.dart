import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/entities/pokemon_type.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';

import '../../helpers/mocks.dart';

void main() {
  late GetPokemonListUseCase usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = GetPokemonListUseCase(repository: mockRepository);
  });

  final tPokemon = PokemonEntity(
    id: '#001',
    name: 'Bulbasaur',
    description: 'desc',
    category: 'Seed',
    imageUrl: 'url',
    height: '2',
    weight: '15',
    hp: 45,
    attack: 49,
    defense: 49,
    specialAttack: 65,
    specialDefense: 65,
    speed: 45,
    total: 300,
    malePercentage: '87.5%',
    femalePercentage: '12.5%',
    eggGroups: 'Monster',
    evolvedFrom: '',
    cycles: '20',
    baseExp: '64',
    weaknesses: const ['Fire'],
    evolutions: const ['#001'],
    types: const [PokemonType.grass],
    abilities: const ['Overgrow'],
    evolveLevel: '16',
  );

  test('should get pokemon list from repository', () async {
    // arrange
    when(() => mockRepository.getPokemonList())
        .thenAnswer((_) async => Right(UnmodifiableListView([tPokemon])));
    // act
    final result = await usecase(NoParams());
    // assert
    result.fold((l) => fail('Expected right, got left'), (r) {
      expect(r, UnmodifiableListView([tPokemon]));
    });
    verify(() => mockRepository.getPokemonList()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure from repository', () async {
    when(() => mockRepository.getPokemonList())
        .thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));

    final result = await usecase(NoParams());

    expect(result, const Left(ServerFailure(message: 'Error')));
  });
}
