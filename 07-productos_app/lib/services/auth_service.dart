import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyATbCxoUiySyxxHScHDHkiPCBo0-RxZXjw';
  final storage = new FlutterSecureStorage();

  Future<String?> createUser( String email, String password ) async {

    // contruir el mapa de los datos a enviar a la api
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    // construir la petición http
    final url = Uri.https( _baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if( decodedResp.containsKey('idToken') ){
      // hay que guardar el idToken
      await storage.write(key: 'idToken', value: decodedResp['idToken']);

      return null;
    } else {
      return '${ decodedResp['error']['message'] }';
    }

  }



  Future<String?> login( String email, String password ) async {

    // contruir el mapa de los datos a enviar a la api
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    // construir la petición http
    final url = Uri.https( _baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if( decodedResp.containsKey('idToken') ){
      // hay que guardar el idToken
      await storage.write(key: 'idToken', value: decodedResp['idToken']);

      return null;
    } else {
      return '${ decodedResp['error']['message'] }';
    }

  }



  Future logout(BuildContext context) async {
    await storage.delete(key: 'idToken');
    Navigator.pushReplacementNamed(context, 'login');
  }

  // verificar token en el sistema
  Future<String> readToken() async{
    return await storage.read(key: 'idToken') ?? '';
  }
}