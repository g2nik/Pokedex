import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';
import 'src/pages/pelicula_detalle.dart';
import 'src/pages/poke_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePage(),
        'detalle' : ( BuildContext context ) => PokeDetalle(),
      },
    );
  }
}