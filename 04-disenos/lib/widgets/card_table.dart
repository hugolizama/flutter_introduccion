import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [

        TableRow(
          children: [
            _SingleCard( icon: Icons.piano, color: Colors.blue, text: 'General',),
            _SingleCard( icon: Icons.map, color: Colors.purple, text: 'Mapa',),
          ]
        ),

        TableRow(
          children: [
            _SingleCard( icon: Icons.car_rental, color: Colors.pinkAccent, text: 'Renta',),
            _SingleCard( icon: Icons.supervised_user_circle, color: Colors.yellowAccent, text: 'Usuarios',),
          ]
        ),

        TableRow(
          children: [
            _SingleCard( icon: Icons.motorcycle, color: Colors.lightBlueAccent, text: 'Motocicletas',),
            _SingleCard( icon: Icons.pedal_bike, color: Colors.amberAccent, text: 'Bicicletas',),
          ]
        ),

        TableRow(
          children: [
            _SingleCard( icon: Icons.wb_sunny, color: Colors.orange, text: 'Verano',),
            _SingleCard( icon: Icons.cloud, color: Colors.deepPurpleAccent, text: 'Clima',),
          ]
        ),
      ],
    );
  }
}


class _SingleCard extends StatelessWidget {

  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({Key? key, required this.icon, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect( // aqui se utiliza para deliminar el blur a cada tarjeta - hugo lizama
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter( // aplicar blur a la tarjeta - hugo lizama
          filter: ImageFilter.blur( sigmaX: 5, sigmaY: 5 ),
          child: Container(          
            height: 180,
            decoration: BoxDecoration( // crear un background - hugo lizama
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Icon( icon, size: 35, ),
                  radius: 30,
                ),
                SizedBox(height: 10,),
                Text('$text', style: TextStyle( color: color, fontSize: 18),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}