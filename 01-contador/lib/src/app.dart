import 'package:contador/src/pages/contador_page.dart';
import 'package:flutter/material.dart';

import '../src/pages/home_page.dart';
import '../src/pages/contador_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: ContadorPage(),
      ),
    );
  }
}
