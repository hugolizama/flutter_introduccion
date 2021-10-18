import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType tipoMapa = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 15.5,
      tilt: 50,
    );

    // marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add( new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon( Icons.my_location_sharp ),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            },
          ),
        ],
      ),

      body: GoogleMap(
        mapType: tipoMapa,
        initialCameraPosition: puntoInicial,
        myLocationButtonEnabled: true,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.layers ),
        onPressed: () {
          setState(() {
            if( tipoMapa == MapType.normal ) {
              tipoMapa = MapType.hybrid;
            } else {
              tipoMapa = MapType.normal;
            }            
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}