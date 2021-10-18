import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          _cardTipo1(),
          SizedBox(height: 10,),
          _cardTipo2(),
        ],
      ),
    );
  }
}


Widget _cardTipo1() {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.photo_album, color: Colors.blue,),
          title: Text('Titylo de la tarjeta'),
          subtitle: Text('subtitulo de la tarjeta que sea la suficiente largo para dos lineas'),
        ),
        Row(
          children: [
            TextButton(
              child: Text('Cancelar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10,),
            TextButton(
              child: Text('Ok'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                foregroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10,),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ],
    ),
  );
}




Widget _cardTipo2() {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      children: [
        FadeInImage(
          image: NetworkImage('https://www.solofondos.com/wp-content/uploads/2016/02/388716.jpg'),
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          height: 210,
          fit: BoxFit.cover,
        ),        
        Container(
          padding: EdgeInsets.all(10),
          child: Text('algo'),
        )
      ],
    ),
  );
}
