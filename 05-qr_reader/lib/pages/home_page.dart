import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/scan_button.dart';
import '../providers/ui_provider.dart';
import '../providers/scan_list_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // titulo
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: () {
              _accionBorrarTodos(context);
            }, 
          ),
        ],
      ),

      // body
      body: _HomePageBody(),

      // barra de navegacion
      bottomNavigationBar: CustomBottomNavitationBar(),

      // boton de accion
      floatingActionButton: ScanButton(),

      // posicion del boton de accion
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _accionBorrarTodos(BuildContext context) async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar registros'),
          content: Text('¿Esta seguro de eliminar los registros?. Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              child: Text('Eliminar'),
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Theme.of(context).primaryColor),
              onPressed: () async {
                // usar el ScanListProvider
                final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

                await scanListProvider.borrarTodos();

                Navigator.of(context).pop();
              }, 
            ),

            TextButton(
              child: Text('Cancelar'),
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.red),
              onPressed: () => Navigator.of(context).pop(), 
            ),
          ],
        );
      },
    );
  }
}


class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // obtener el selectedMenuOpt del provider
    final uiProvider = Provider.of<UiProvider>(context);

    // cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch ( currentIndex ) {
      case 0:
        scanListProvider.cargarScansPorTipo( 'geo' );       
        return MapasPage();
        break;

      case 1:
        scanListProvider.cargarScansPorTipo( 'http' );      
        return DireccionesPage();
        break;

      default:
        scanListProvider.cargarScansPorTipo( 'geo' );  
        return MapasPage();
    }
  }
}