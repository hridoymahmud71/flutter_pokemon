import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//own
import 'package:flutter_pokemon/config/poke_config.dart';
import 'package:flutter_pokemon/models/pokemon.dart';

class GridItem extends StatefulWidget {
  String url;

  GridItem(url) {
    url = url;
  }

  @override
  _GridItemState createState() => _GridItemState(url);
}

class _GridItemState extends State<GridItem> {
  String url;
  Pokemon pokemon;
  final int imageWidth = 250;

  String name;
  NetworkImage image;


  _GridItemState(url) {
    url = url;
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  fetchPokemon() async {
    var res = await http.get(url);
    print(res.body);
    var decodedJson = jsonDecode(res.body);

    pokemon = Pokemon.fromJson(decodedJson);
    name = pokemon != null && pokemon.name != null
        ?  pokemon.name : "<Unknown>";
    image = pokemon != null && pokemon.sprites.frontDefault != null
        ? NetworkImage(PokeConfig.placeholderUrl(imageWidth))
        : NetworkImage(pokemon.sprites.frontDefault);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image
                ),
              ),
            ),
            Text(
                name,
            )
          ],
        ),
      ),
    );
  }
}
