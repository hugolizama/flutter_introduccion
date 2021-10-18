import 'package:flutter/material.dart';
import '../widgets/menu_widget.dart';
import '../shared_prefs/preferencias_usuario.dart';

class HomePage extends StatelessWidget {

  static final String routeName = 'home';
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    _prefs.ultimaPagina = HomePage.routeName;

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Preferencias de usuario'),
        backgroundColor: _prefs.getColor(),
      ),

      drawer: MenuWidget(),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Color secundario: ${ _prefs.colorSecundario }'),
          Divider(),

          Text('Género: ${ _prefs.genero }'),
          Divider(),

          Text('Nombre usuario: ${ _prefs.nombreUsuario }'),
          Divider(),
        ],
      ),
    );
  }  
}