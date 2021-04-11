import 'package:flutter/material.dart';
import 'package:mybinder/screens/login.dart';
import 'package:mybinder/screens/mybinder.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  bool isLoggedIn = false;
  
  @override
  Widget build(BuildContext context) {
    if(isLoggedIn){
      return new MaterialApp(
      theme: ThemeData.dark(),
      home: new MyBinder(),
    );
    }
    else{
      return new MaterialApp(
      theme: ThemeData.dark(),
      home: new LoginPage(),
    );
    }
    
  }
}