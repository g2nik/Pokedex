import 'package:flutter/material.dart';
import 'package:pokedex/src/models/poke_model.dart';
import '../models/actores_model.dart';
import '../models/pelicula_model.dart';
import '../providers/poke_provider.dart';

class PokeDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Pokemon pokemon = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( pokemon ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _posterTitulo( context, pokemon ),
                _descripcion( pokemon ),
                _descripcion( pokemon ),
                _descripcion( pokemon ),
                _descripcion( pokemon ),
                _crearCasting( pokemon )
              ]
            ),
          )
        ],
      )
    );
  }


  Widget _crearAppbar( Pokemon pokemon ) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pokemon.name,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pokemon.imageUrl),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );

  }

  Widget _posterTitulo(BuildContext context, Pokemon pokemon ){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pokemon.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( pokemon.imageUrl ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pokemon.name, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ),
                Text(pokemon.rating.toString(), style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( pokemon.firstType.toString(), style: Theme.of(context).textTheme.subhead )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _descripcion( Pokemon pokemon ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pokemon.name,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pokemon pokemon) {
    final peliProvider = new PokeProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pokemon.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {

        return snapshot.hasData
        ? _crearActoresPageView(snapshot.data)
        : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _crearActoresPageView( List<Actor> actores ) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) =>_actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta( Actor actor ) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getFoto() ),
              placeholder: AssetImage('assets/pokeball.png'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      )
    );
  }
}