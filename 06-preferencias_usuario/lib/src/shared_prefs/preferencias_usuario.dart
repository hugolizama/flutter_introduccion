import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }


  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;  

  getColor() {
    return ( colorSecundario == true ) ? Colors.teal : Colors.blue;
  }

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  // get y set del genero
  int get genero{
    return _prefs.getInt('genero') ?? 1;
  }

  set genero( int valor ){
    this._prefs.setInt('genero', valor);
  }


  // get y set del colorSecundario
  bool get colorSecundario{
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario( bool valor ){
    this._prefs.setBool('colorSecundario', valor);
  }


  // get y set del nombreUsuario
  String get nombreUsuario{
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario( String valor ){
    this._prefs.setString('nombreUsuario', valor);
  }



  // get y set del ultimaPagina
  String get ultimaPagina{
    return _prefs.getString('ultimaPagina') ?? HomePage.routeName;
  }

  set ultimaPagina( String valor ){
    this._prefs.setString('ultimaPagina', valor);
  }
}