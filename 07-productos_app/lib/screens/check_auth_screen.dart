import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            
            if(!snapshot.hasData){ // esta cargando
              return CircularProgressIndicator();

            } else if( snapshot.data == '' ) { // no hay token puesto
              // redirigir a la pantalla de login
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                  transitionDuration: Duration(seconds: 0),
                ));
              });

              return Container();
            } else {
              // redirigir a home
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                  transitionDuration: Duration(seconds: 0),
                ));
              });

              return Container();
            }

          },
        ),
      ),
    );
  }
}