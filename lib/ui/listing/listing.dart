import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//own
import 'package:flutter_pokemon/config/poke_config.dart';
import 'package:flutter_pokemon/models/pokemon_list.dart';

import 'grid_item.dart';

class Listing extends StatefulWidget {
  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  PokemonList pokemonList;
  List<Results> itemList;
  int itemCount;
  final int crossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  fetchPokemonList() async {
    var res = await http.get(PokeConfig.getListingUrl());
    //ssprint(res.body);
    var decodedJson = jsonDecode(res.body);

    setState(() {
      pokemonList = PokemonList.fromJson(decodedJson);
      itemList = pokemonList != null ? pokemonList.results : List<Results>();
      itemCount = itemList != null ? itemList.length : 0;
    });


  }

  @override
  Widget build(BuildContext context) {
    return pokemonList == null
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int position) {
              return itemList != null
                  ? GridItem(itemList[position].url)
                  : GridItem(PokeConfig.getSingleUrl(0));
            },
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
          );
  }
}
