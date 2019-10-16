import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/pokemon.dart';
import '../screens/detail.dart';

class PokemonItem extends StatelessWidget {
  final PokemonModel model;

  PokemonItem({
    @required this.model,
  });

  static Color backgroundColor(String type) {
    switch (type) {
      case 'bug':
        return Color(0xffA6B91A);
      case 'dark':
        return Color(0xff705746);
      case 'dragon':
        return Color(0xff6F35FC);
      case 'electric':
        return Color(0xffF7D02C);
      case 'fairy':
        return Color(0xffD685AD);
      case 'fighting':
        return Color(0xffC22E28);
      case 'fire':
        return Color(0xffEE8130);
      case 'flying':
        return Color(0xffA98FF3);
      case 'ghost':
        return Color(0xff735797);
      case 'grass':
        return Color(0xff7AC74C);
      case 'ground':
        return Color(0xffE2BF65);
      case 'ice':
        return Color(0xff96D9D6);
      case 'normal':
        return Color(0xffA8A77A);
      case 'poison':
        return Color(0xffA33EA1);
      case 'psychic':
        return Color(0xffF95587);
      case 'rock':
        return Color(0xffB6A136);
      case 'shadow':
        return Color(0xff000000);
      case 'steel':
        return Color(0xffB7B7CE);
      case 'unknown':
        return Color(0xff000000);
      case 'water':
        return Color(0xff6390F0);

      default:
        return Colors.black;
    }
  }

  static Color textColor(String type) {
    switch (type) {
      case 'bug':
      case 'dark':
      case 'dragon':
      case 'fairy':
      case 'fighting':
      case 'fire':
      case 'flying':
      case 'ghost':
      case 'grass':
      case 'poison':
      case 'psychic':
      case 'rock':
      case 'shadow':
      case 'steel':
      case 'unknown':
      case 'water':
        return Colors.white70;

      case 'electric':
      case 'ground':
      case 'ice':
      case 'normal':
        return Colors.black54;

      default:
        return Colors.red;
    }
  }

  Widget buildType(String type) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2.0,
        ),
        decoration: BoxDecoration(
          color: backgroundColor(type),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          '${type}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor(type),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Widget type = this.model.types.length == 1
        ? buildType(this.model.types[0])
        : Row(children: <Widget>[
            Expanded(
              child: buildType(this.model.types[0]),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: buildType(this.model.types[1]),
            ),
          ]);

    final number = this.model.id.toString().padLeft(3, '0');
    final name = this.model.name.toUpperCase();
    final title = '$number - $name';

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              model: this.model,
            ),
          ),
        );
      },
      leading: Hero(
        tag: this.model.sprite,
        child: CircleAvatar(
          backgroundImage: NetworkImage(this.model.sprite),
        ),
      ),
      title: Text(title),
      subtitle: type,
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
