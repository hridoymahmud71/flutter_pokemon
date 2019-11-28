import 'package:flutter/material.dart';
import 'package:flutter_pokemon/ui/listing/listing.dart';

void main() => runApp(PokemonApp());

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange[800],
        accentColor: Colors.greenAccent[600],
        primaryColorDark: Colors.indigo,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title:'Pokemon',
      home:Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Know your pokemon'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer:MainDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){

        },
        child:Icon(Icons.update)
      ),
      body:Listing(),
    );
  }


}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


