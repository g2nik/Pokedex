import 'package:flutter/material.dart';
import 'src/pages/home_page.dart';
import 'src/pages/poke_deatil.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    
    //I renamed the title to Pokedex
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePage(),
        'detail' : ( BuildContext context ) => PokeDetalle(),
      },
    );
  }
}