import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final Map <int, String> rutas = {
    0: 'home_screen',
    1: 'basic_design',
    2: 'scroll_design',
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.pink,
      backgroundColor: Color.fromRGBO(55, 57, 84, 1),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        final String ruta = this.rutas[index]!;
        Navigator.pushNamed(context, ruta);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.calendar_today_outlined ),
          label: 'Calendario'
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.pie_chart_outline ),
          label: 'Gráfica'

        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.supervised_user_circle_outlined ),
          label: 'Usuarios'

        ),
      ]
    );
  }
}