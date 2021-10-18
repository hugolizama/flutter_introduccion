import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import './screens/basic_design.dart';
import './screens/scroll_design.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // forzar color de la barra de estado - hugo lizama
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home_screen',
      routes: {
        'basic_design': ( _ ) => BasicDesignScreen(),
        'scroll_design': ( _ ) => ScrollDesignScreen(),
        'home_screen': ( _ ) => HomeScreen(),
      },
    );
  }
}
