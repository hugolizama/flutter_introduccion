import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // imagen
          Container(
            padding: EdgeInsets.only( bottom: 20 ),
            child: Image(image: AssetImage('assets/img/kratos.jpg'),)
          ),

          // titulo
          Title(),

          // seccion de iconos
          ButtonSection(),

          //Description
          Description(),

        ],
      )
    );
  }
}




class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Texto lake noseque titulo', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),),

              SizedBox(height: 3,),

              Text('Subtitulo swiss noseque', style: TextStyle(
                color: Colors.grey,
              ),),
            ],
          ),

          Expanded(child: Container()), // Elemento para generar un espacio entre componentes

          Icon( Icons.star, color: Colors.red, ),
          Text('41'),
        ],
      ),
    );
  }
}


class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 80, right: 80, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //CALL
          Column(
            children: [
              Icon( Icons.call , color: Colors.lightBlue,),
              SizedBox(height: 5,),
              Text('CALL', style: TextStyle(
                color: Colors.lightBlue
              ),),
            ],
          ),


          //ROUTE
          Column(
            children: [
              Icon( Icons.navigation_outlined , color: Colors.lightBlue,),
              SizedBox(height: 5,),
              Text('ROUTE', style: TextStyle(
                color: Colors.lightBlue
              ),),
            ],
          ),


          //SHARE
          Column(
            children: [
              Icon( Icons.share , color: Colors.lightBlue,),
              SizedBox(height: 5,),
              Text('SHARE', style: TextStyle(
                color: Colors.lightBlue
              ),),
            ],
          ),
        ],
      ),
    );
  }
}


class Description extends StatelessWidget {
  const Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 30 ),
      child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

