import 'package:flutter/material.dart';
import 'package:pokedexapp/core/theme/app_theme.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_provider.dart';
import 'package:pokedexapp/feature/pokemon/screens/pokemon_list_screen.dart';
import 'package:provider/provider.dart';
import 'core/services/service_locator.dart' as di;
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => locator<PokemonProvider>(),
      child: MaterialApp(
        theme: AppTheme.light,
        home: PokemonListScreen(),
      ),
    );
  }
}
