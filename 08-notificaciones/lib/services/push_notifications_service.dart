import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/**
 * Variant: profileUnitTest
  Config: debug
  Store: C:\Users\hugol\.android\debug.keystore
  Alias: AndroidDebugKey
  MD5: 4F:52:79:1D:AF:93:71:70:CB:B1:9D:C9:81:01:B8:E2
  SHA1: 4F:7D:A1:08:30:90:25:27:FF:64:E3:CA:BA:18:E3:D8:84:FA:4A:A2
  SHA-256: 9C:AC:B1:DB:81:83:A9:9A:C0:EE:CC:2D:9F:88:7A:F3:A1:A8:B2:3C:01:71:14:99:AE:
  Valid until: jueves 20 de julio de 2051
 */

class PushNotificactionsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;


  static Future _onBackroundHandler( RemoteMessage message ) async {
    // print('On BackgroundHandler ${ message.messageId }');

    _messageStream.add( message.data['producto'] ?? 'No data' );
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
    // print('On MessageHandler ${ message.messageId }');
    print( message.data );

    _messageStream.add( message.data['producto'] ?? 'No data' );

  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {
    // print('On MessageOpenApp ${ message.messageId }');

    _messageStream.add( message.data['producto'] ?? 'No data' );

  }

  static Future initializeApp() async {
    // push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token Firebase: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage( _onBackroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

    // local notifications
  }


  // no se utiliza pero es necesario para quitar la adventertencia de 
  // la declaracion de la variable.
  static closeStreams(){
    _messageStream.close();
  }



}