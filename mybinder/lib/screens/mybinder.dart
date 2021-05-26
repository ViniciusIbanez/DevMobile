import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';

class MyBinder extends StatefulWidget {
  String user;
  MyBinder({Key key, this.user}) : super(key: key);

  @override
  _MyBinderState createState() => _MyBinderState();
}

class _MyBinderState extends State<MyBinder> {
  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ApiHandler api = new ApiHandler();
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new ListView(children: <Widget>[
      ListTile(
        title: Text("Battery Full"),
        leading: Image.asset(
          "assets/logo.png",
          width: 50.0,
          height: 50.0,
        ),
      ),
      ListTile(title: Text("Anchor"), leading: Icon(Icons.anchor)),
      ListTile(title: Text("Alarm"), leading: Icon(Icons.access_alarm)),
      ListTile(title: Text("Ballot"), leading: Icon(Icons.ballot))
    ]));
  }
}
