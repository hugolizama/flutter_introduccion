import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/screens.dart';
import '../services/services.dart';
 
void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // lazy en false indica que se ejecute inmediatamente, en true se ejecutaria hasta ser utilizado
        ChangeNotifierProvider(create: (_) => AuthService(), lazy: false,),
        ChangeNotifierProvider(create: (_) => ProductsService(), lazy: true,),
      ],

      child: MyApp(),
    );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'register': ( _ ) => RegisterScreen(),
        'home': ( _ ) => HomeScreen(),
        'product': ( _ ) => ProductScreen(),
        'checking': ( _ ) => CheckAuthScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
        
      ),
    );
  }
}