import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../models/poke_model.dart';
import 'poke_type.dart';

class PokeSwiper extends StatefulWidget {
  final List<Pokemon> pokemons;
  
  PokeSwiper({ @required this.pokemons });

  @override
  _PokeSwiperState createState() => _PokeSwiperState();
}

class _PokeSwiperState extends State<PokeSwiper> {
  Future<Pokemon> futurePokemon;
  int keyIndex = 0;

  Future<Pokemon> _futurePokemonData() async => await widget.pokemons[keyIndex].load();

  @override
  void initState() {
  futurePokemon = _futurePokemonData();
  super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

      return FutureBuilder(
          future: futurePokemon,
          builder: (context, data) {
            return data.hasData
            ? Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Swiper(
                      layout: SwiperLayout.STACK,
                      itemWidth: _screenSize.width,
                      itemHeight: _screenSize.height * .5,
                      itemCount: widget.pokemons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Hero(
                          tag: widget.pokemons[index].id.toString(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GestureDetector(
                              onTap: () {
                                if (widget.pokemons[index].loaded) Navigator.pushNamed(context, 'detalle', arguments: widget.pokemons[index]);
                              },
                              child: FadeInImage(
                                image: NetworkImage(widget.pokemons[index].imageUrl),
                                placeholder: AssetImage('assets/pokeball.png'),
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                        );
                      },
                      onIndexChanged: (index) {
                        setState(() => keyIndex = index);
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      "${widget.pokemons[keyIndex].name} #${widget.pokemons[keyIndex].id}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 20),
                    PokeTypes(widget.pokemons[keyIndex]),
                ],
              ),
            )
            : Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),));
          });
      }
}
