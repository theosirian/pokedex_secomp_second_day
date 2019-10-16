import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class DetailPage extends StatelessWidget {
  final PokemonModel model;

  DetailPage({
    @required this.model,
  });

  Widget get sprite => Hero(
        tag: this.model.sprite,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            this.model.sprite,
            scale: 4.0,
          ),
        ),
      );

  Widget get number => Text(
        '${this.model.id.toString().padLeft(3, '0')}',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      );

  Widget get name => Text(
        '${this.model.name.toUpperCase()}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget buildValueWithUnit(double value, String unit) => Text.rich(
        TextSpan(
            text: '$value ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]),
      );

  Widget get weight => buildValueWithUnit(this.model.weight, 'kg');

  Widget get height => buildValueWithUnit(this.model.height, 'cm');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(model.name),
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 24.0),
              this.sprite,
              const SizedBox(height: 16.0),
              this.number,
              const SizedBox(height: 4.0),
              this.name,
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: this.weight),
                  ),
                  Expanded(
                    child: Center(child: this.height),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
