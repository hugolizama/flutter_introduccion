import 'package:flutter/material.dart';

import '../providers/menu_provider.dart';
import '../utils//icono_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {

    return FutureBuilder(
      future: menuProvider.cargarData(),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){

        return ListView(
          children: _listaItems( snapshot.data, context ),
        );
      },
    );
  }

  List<Widget> _listaItems( List<dynamic>? data, BuildContext context ) {
    
    final List<Widget> opciones = [];

    data?.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.arrow_right, color: Colors.blue,),
        onTap: (){

          // Metodo 1 de navegacion
          // final route = MaterialPageRoute(
          //   builder: (context){
          //     return AlertPage();
          //   }
          // );
          // Navigator.push(context, route);


          // Metodo 2 de navegacion
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      
      opciones..add(widgetTemp)
              ..add(Divider());      
    });

    return opciones;

  }
}
