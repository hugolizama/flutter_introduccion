import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/page_title.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/card_table.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // backgrpound
          Background(),

          // home body
          _HomeBody(),
        ],
      ),

      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // titulos
          PageTitle(),

          //card table
          CardTable(),
        ],
      ),
    );
  }
}