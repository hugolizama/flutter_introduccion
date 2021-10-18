import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  //
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // color de fonto
          _PurpleBox(),

          // icono
          SafeArea(
            child: Container(
              margin: EdgeInsets.only( top: 40 ),
              width: double.infinity,
              height: 200,
              child: Icon( Icons.person_pin, color: Colors.white, size: 90, ),
            ),
          ),

          // caja de login
          this.child
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ]
        ),
      ),

      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: -20, left: -30,),
          Positioned(child: _Bubble(), top: 120, left: 30,),
          Positioned(child: _Bubble(), top: 40, left: 300,),
          Positioned(child: _Bubble(), top: 180, left: 160,),
          Positioned(child: _Bubble(), bottom: -40, right: -20,),
        ],
      ),
    );
  }
}


class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}