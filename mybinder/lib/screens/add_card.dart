import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/screens/home.dart';

class AddCard extends StatefulWidget {
  String user;
  AddCard({Key key, this.user}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Padding(padding: const EdgeInsets.only(top: 15.0)),
        Text(
          "*Tela em desenvolvimento, o botão abaixo irá adicionar uma carta aleatória na pasta",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        new Padding(padding: const EdgeInsets.only(top: 100.0)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            api.insertRandomCard(auth.currentUser.uid);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Text('Adicionar Carta'),
        )
      ],
    ));
  }
}
