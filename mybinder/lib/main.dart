import 'package:flutter/material.dart';
import 'package:mybinder/screens/login.dart';
import 'package:mybinder/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return new MaterialApp(
        theme: ThemeData.dark(),
        home: new Home(
          user: '',
        ),
      );
    } else {
      return new MaterialApp(
        theme: ThemeData.dark(),
        home: new LoginPage(),
      );
    }
  }
}
