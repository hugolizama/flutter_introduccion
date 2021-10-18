import 'package:flutter/material.dart';
import 'package:notificaciones/screens/screens.dart';
import 'package:notificaciones/services/services.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificactionsService.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //acceso al context
    PushNotificactionsService.messageStream.listen((message) {
      // print('MyApp: $message');

      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'message': (_) => MessageScreen(),
      },
    );
  }
}