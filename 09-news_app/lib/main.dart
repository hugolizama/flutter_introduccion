import 'package:flutter/material.dart';
import 'package:news_app/src/services/services.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:provider/provider.dart';
import '../src/pages/pages.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: TabsPage(),
      ),
    );
  }
}