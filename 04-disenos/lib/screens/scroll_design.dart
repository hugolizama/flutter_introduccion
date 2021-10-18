import 'package:flutter/material.dart';

class ScrollDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        decoration: BoxDecoration(          
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.5, 0.5
            ],
            colors: [
              Color(0xff5EE8C5),
              Color(0xff30BAD6),
            ]
          ),
        ),


        child: PageView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
             Page1(),
             Page2(),
          ],
        ),


      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //background image
        Background(),

        //contenido
        MainContent(),
      ],
    );
  }
}


class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff30BAD6),
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: Image( image: AssetImage('assets/img/scroll-1.png'), ),
    );
  }
}


class MainContent extends StatelessWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle( color: Colors.white, decoration: TextDecoration.none, fontSize: 50 );

    // hugo lizama
    // SafeArea: Hace que el contenido se muestre en la zona de vision del dispositivo 
    return SafeArea(     
      child: Container(
        margin: EdgeInsets.only( top: 20 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('11°', style: textStyle,),
            Text('Miércoles', style: textStyle,),
            Expanded(child: Container()),
            Icon( Icons.keyboard_arrow_down, size: 100, color: Colors.white, )
          ],
        ),
      ),
    );
  }
}


class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff30BAD6),
      child: Center(
        child: TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 0 ),
            child: Text('Bienvenido', style: TextStyle(
              color: Colors.white,
              fontSize: 30
            ),),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff0098FA),
            shape: StadiumBorder()
          ),
          onPressed: () {}
        ),
      ),
    );
  }
}