
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../src/models/actores_model.dart';
import '../../src/models/pelicula_model.dart';
import '../models/poke_model.dart';

class PokeProvider {
  int _popularesPage = 0;
  bool _cargando     = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() => _popularesStreamController?.close();

  Future<List<Pokemon>> _procesarRespuesta(int start, int number) async {
    List<Pokemon> pokemons = new List();
    for (int i = start; i < start + number; i++) pokemons.add(Pokemon(i.toString()));
    return pokemons;
  }

  Future<List<Pokemon>> getEnCines() async {
    return await _procesarRespuesta(4,5);
  }


  Future<List<Pokemon>> getPopulares() async {
    if ( _cargando ) return [];
    _cargando = true;
    _popularesPage++;

    String url = "https://pokeapi.co/api/v2/pokemon/lucario";

    final resp = await _procesarRespuesta(5,5);
    //_populares.addAll(resp);
    popularesSink( _populares );
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast( String peliId ) async {
    String url = "https://pokeapi.co/api/v2/pokemon/lucario";
    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }


  Future<List<Pokemon>> buscarPelicula( String query ) async {
    String url = "https://pokeapi.co/api/v2/pokemon/lucario";
    return await _procesarRespuesta(3,10);
  }
}
