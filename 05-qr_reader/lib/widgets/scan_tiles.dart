import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class ScanTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    final IconData icono;

    // seleccionar icono a mostrar
    if( scanListProvider.tipoSeleccionado == 'http'){
      icono = Icons.http;
    } else {
      icono = Icons.map;
    }


    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(        
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        child: ListTile(
          leading: Icon( icono , color: Theme.of(context).primaryColor),
          title: Text( scans[i].valor ),
          subtitle: Text('ID: ${ scans[i].id }'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
          onTap: () =>  launchURL(context, scans[i])
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId( scans[i].id! );
          // print(scans[i].id.toString());
        },
      )
      
    );;
  }
}