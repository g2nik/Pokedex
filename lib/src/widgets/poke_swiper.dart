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
  //I use keyIndex to controll which pokemon of the list is selected
  int keyIndex = 0;

  Future<Pokemon> _futurePokemonData() async => await widget.pokemons[keyIndex].load();

  //When the widget loads for the first time i run _futurePokemonData, which loads into the
  //futurePokemon list a list of pokemons provided by the API
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
                                //I check that the pokemon data has been loaded and open the pokemon
                                if (widget.pokemons[index].loaded) Navigator.pushNamed(context, 'detail', arguments: widget.pokemons[index]);
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
                        //I change the keyIndex when the user swipes one way or another
                        setState(() => keyIndex = index);
                      },
                    ),
                    SizedBox(height: 30),
                    //Here is shown the pokemon name and id
                    Text(
                      "${widget.pokemons[keyIndex].name} #${widget.pokemons[keyIndex].id}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 20),
                    //I display the pokemon type/s
                    PokeTypes(widget.pokemons[keyIndex]),
                ],
              ),
            )
            //In case the data is still loading i use a red circle
            : Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),));
          });
      }
}
