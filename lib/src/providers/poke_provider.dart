import 'dart:async';
import '../models/poke_model.dart';

class PokeProvider {
  Future<List<Pokemon>> _procesarRespuesta(int start, int number) async {
    List<Pokemon> pokemons = new List();
    for (int i = start; i < start + number; i++) pokemons.add(Pokemon(i.toString(), true));
    return pokemons;
  }

  Future<List<Pokemon>> getPokemons() async => await _procesarRespuesta(1,15);

  Future<Pokemon> buscarPokemon(String name) async {
    Pokemon pkmn = new Pokemon(name, false);
    await pkmn.load();
    return pkmn;
  }
}
