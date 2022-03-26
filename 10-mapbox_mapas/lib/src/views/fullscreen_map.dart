import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  final _ACCESS_TOKEN = dotenv.env['access_token']!;
  final LatLng center = LatLng(13.728541, -89.218461);
  final streetStyle = 'mapbox://styles/hugolizama22/ckuwthwly229z17p7phr02snv';
  final oscuroStyle = 'mapbox://styles/hugolizama22/ckuwu3l2t72rk17nzjxw1d5uk';
  String selectedStyle =
      'mapbox://styles/hugolizama22/ckuwthwly229z17p7phr02snv';

  MapboxMapController? mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void onStyleLoadedCallback() {}

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/img/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Simbolos
          FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: () {
                mapController!.addSymbol(
                  SymbolOptions(
                    geometry: center,
                    iconSize: 3,
                    iconImage: 'assetImage',
                    // iconImage: 'attraction-15',
                    textField: 'Montaña aqui',
                    textOffset: Offset(0, 2),
                  ),
                );
              }),

          SizedBox(
            height: 10,
          ),

          // Zoom in
          FloatingActionButton(
              child: Icon(Icons.zoom_in),
              onPressed: () {
                mapController!.animateCamera(CameraUpdate.zoomIn());
              }),

          SizedBox(
            height: 10,
          ),

          // Zoom out
          FloatingActionButton(
              child: Icon(Icons.zoom_out),
              onPressed: () {
                mapController!.animateCamera(CameraUpdate.zoomOut());
              }),

          SizedBox(
            height: 10,
          ),

          // Cambiar Estilo
          FloatingActionButton(
            child: Icon(Icons.layers),
            onPressed: () {
              if (selectedStyle == oscuroStyle) {
                selectedStyle = streetStyle;
              } else {
                selectedStyle = oscuroStyle;
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      accessToken: _ACCESS_TOKEN,
      styleString: this.selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: this.center, zoom: 15),
      onStyleLoadedCallback: onStyleLoadedCallback,
    );
  }
}
