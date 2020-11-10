import 'dart:async';
import '../models/poke_model.dart';

class PokeProvider {
  //Returns a list with X number of pokemons from id Y
  //X = number and Y = start
  Future<List<Pokemon>> _fetchPokeList(int start, int number) async {
    List<Pokemon> pokemons = new List();
    for (int i = start; i < start + number; i++) pokemons.add(Pokemon(i.toString(), true));
    return pokemons;
  }

  //Getpokemons returns 15 pokemons from id 1
  Future<List<Pokemon>> getPokemons() async => await _fetchPokeList(1,15);

  //In order to seach a pokemon i  create it, wait for it to load and return it
  Future<Pokemon> searchPokemon(String name) async {
    Pokemon pkmn = new Pokemon(name, false);
    await pkmn.load();
    return pkmn;
  }
}
