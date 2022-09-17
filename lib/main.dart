import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() async {
  //firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'AFK MART',

      //app theme
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      //initial route (Name Route)
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the login page.
        '/': (context) => LogIn(),
      },
    );
  }
}
