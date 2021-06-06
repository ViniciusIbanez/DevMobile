import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';

class Settings extends StatefulWidget {
  String user;
  Settings({Key? key, required this.user}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //new Padding(padding: const EdgeInsets.only(top: 15.0)),
        Text(
          "* Tela em desenvolvimento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        //new Padding(padding: const EdgeInsets.only(top: 15.0)),
      ],
    ));
  }
}
