import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ui_provider.dart';

class CustomBottomNavitationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // obtener el selectedMenuOpt del provider
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          label: 'Mapa'
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.http ),
          label: 'Direcciones'
        ),
      ],   
      onTap: (index) => uiProvider.selectedMenuOpt = index,   
    );
  }
}