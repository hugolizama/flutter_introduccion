import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/pages.dart';
import './providers/ui_provider.dart';
import './providers/scan_list_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (BuildContext context) => new UiProvider(), ),
        ChangeNotifierProvider( create: (BuildContext context) => new ScanListProvider(), ),        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': ( BuildContext context ) => HomePage(),
          'mapa': ( BuildContext context ) => MapaPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepPurple,
          ),
          
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurpleAccent
          )
        ),
      ),
    );
  }
}