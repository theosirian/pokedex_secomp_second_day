import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';
import '../widgets/pokemon_item.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<PokemonModel> data = [];
  String error = null;

  @override
  void initState() {
    super.initState();

    this.loadData();
  }

  static String baseUrl = 'https://pokeapi.theosirian.com/api/v2';

  Future<PokemonModel> loadItem(String name) async {
    final model = await http.get('$baseUrl/pokemon/$name');

    if (model.statusCode != 200) {
      print('Status Code: ${model.statusCode}');
      throw ('Ocorreu um erro!');
    }

    return PokemonModel.fromJson(jsonDecode(model.body));
  }

  void loadData() async {
    final list = await http.get('$baseUrl/pokemon?limit=9');

    if (list.statusCode != 200) {
      print('Status Code: ${list.statusCode}');
      setState(() {
        this.error = 'Ocorreu um erro!';
      });
      return;
    }

    final List<PokemonModel> data = <PokemonModel>[];

    for (final item in jsonDecode(list.body)['results']) {
      try {
        final PokemonModel model = await this.loadItem(item['name']);
        data.add(model);
      } catch (e) {
        print('Error: $e');
        setState(() {
          this.error = 'Ocorreu um erro!';
        });
        return;
      }
    }

    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var body;
    if (this.error != null) {
      // Ocorreu um erro!
      body = Center(
        child: Text(
          this.error,
          style: TextStyle(
            color: Colors.red,
            fontSize: 24.0,
          ),
        ),
      );
    } else if (this.data.length == 0) {
      // Ainda está carregando.
      body = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Lista de pokémons
      body = ListView.builder(
        itemCount: this.data.length,
        itemBuilder: (context, index) => PokemonItem(
          model: this.data[index],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: body,
    );
  }
}
