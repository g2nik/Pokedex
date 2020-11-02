import 'package:flutter/material.dart';
import '../../src/providers/peliculas_provider.dart';
import '../../src/providers/poke_provider.dart';
import '../../src/search/search_delegate.dart';
import '../../src/widgets/card_swiper_widget.dart';
import '../../src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final pokeProvider = new PokeProvider();

  @override
  Widget build(BuildContext context) {
    pokeProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            //_footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: pokeProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData
        ? CardSwiper(pokemons: snapshot.data)
        : Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator())
          );
        }
    );
  }
}