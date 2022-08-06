import 'package:flutter/material.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_provider.dart';
import 'package:provider/provider.dart';

class EvolutionTab extends StatefulWidget {
  final PokemonModel pokemonModel;

  const EvolutionTab({Key key, this.pokemonModel}) : super(key: key);

  @override
  _EvolutionTabState createState() => _EvolutionTabState();
}

class _EvolutionTabState extends State<EvolutionTab> {
  List<PokemonModel> _evolutions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final evolutions = widget.pokemonModel.evolutions;
    evolutions.forEach((id) {
      final pokemon = Provider.of<PokemonProvider>(context, listen: false)
          .getPokemonById(id);
      _evolutions.add(pokemon);
    });
  }

  Widget _buildEvolution(
      PokemonModel firstPokemon, PokemonModel secondPokemon) {
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
                  'assets/images/pokeball.png',
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
                  'assets/images/pokeball.png',
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
        Center(
          child: Text('No Evolutions available'),
        )
      ];
    }
    return Iterable<int>.generate(_evolutions.length - 1)
        .map((index) =>
            _buildEvolution(_evolutions[index], _evolutions[index + 1]))
        .expand((widget) => [
              widget,
              Divider(
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
