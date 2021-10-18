
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/scan_model.dart';

launchURL( BuildContext context, ScanModel scan ) async {
  final url = scan.valor;


  if( scan.tipo == 'http'){
    // abrir sitio web
    if(await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    // llevar a pagina de mapas para los tipo geo
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }

}
    