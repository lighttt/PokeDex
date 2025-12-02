import 'package:flutter/material.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_images.dart';

class EvolutionTab extends StatefulWidget {
  final PokemonEntity pokemonModel;

  const EvolutionTab({Key? key, required this.pokemonModel}) : super(key: key);

  @override
  _EvolutionTabState createState() => _EvolutionTabState();
}

class _EvolutionTabState extends State<EvolutionTab> {
  List<PokemonEntity> _evolutions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadEvolutions();
  }

  void _loadEvolutions() {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    _evolutions = widget.pokemonModel.evolutions.map((id) => provider.getPokemonById(id)).toList();
  }

  Widget _buildEvolution(PokemonEntity firstPokemon, PokemonEntity secondPokemon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.network(
              firstPokemon.imageUrl,
              height: 100,
              errorBuilder: (src, _, __) {
                return Image.asset(
                  AppImages.pokeBall,
                  height: 80,
                );
              },
            ),
            Text(
              firstPokemon.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(Icons.arrow_forward),
            Text(
              secondPokemon.evolveLevel,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        Column(
          children: [
            Image.network(
              secondPokemon.imageUrl,
              height: 100,
              errorBuilder: (src, _, __) {
                return Image.asset(
                  AppImages.pokeBall,
                  height: 80,
                );
              },
            ),
            Text(
              secondPokemon.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }

  List<Widget> _buildEvolutionList() {
    if (_evolutions.length < 2) {
      return [
        const Center(
          child: Text('No Evolutions available'),
        )
      ];
    }
    return Iterable<int>.generate(_evolutions.length - 1)
        .map((index) => _buildEvolution(_evolutions[index], _evolutions[index + 1]))
        .expand((widget) => [
              widget,
              const Divider(
                thickness: 1.2,
              )
            ])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildEvolutionList(),
    );
  }
}
