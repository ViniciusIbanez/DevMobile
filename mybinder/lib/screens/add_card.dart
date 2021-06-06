import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/screens/home.dart';
import 'package:mybinder/cards.dart';
import 'package:mybinder/binder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddCard extends StatefulWidget {
  List<Binder> cards;
  List<Binder> binder;
  AddCard({Key key, this.cards, this.binder}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dropdownValue = '1';
  bool shouldRetrieveCards = true;

  @override
  Future<void> initState() {
    super.initState();
  }

  Future<bool> addCard(Binder card, List<Binder> binder) async {
    binder.add(card);
  }

  Future<bool> retrieveAllCards(List<Binder> cards) async {
    bool response = true;
    if (shouldRetrieveCards) {
      shouldRetrieveCards = false;
      response = await api.retrieveAllCards(cards);
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveAllCards(widget.cards),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                  new Padding(padding: const EdgeInsets.only(top: 10.0)),
                  Text("Carregando",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12))
                ],
              ),
            );
          }

          return Scaffold(
              body: new Stack(fit: StackFit.expand, children: <Widget>[
            new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  inputDecorationTheme: new InputDecorationTheme(
                    hintStyle:
                        new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle:
                        new TextStyle(color: Colors.blue, fontSize: 25.0),
                  )),
              child: SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    new Image(
                      image: new AssetImage("assets/logo.png"),
                    ),
                    SizedBox(height: 20),
                    new Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Form(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Nome da carta",
                                  // suffixIcon:
                                  //     Icon(Icons.card_giftcard, color: Colors.blue),
                                  fillColor: Colors.blue),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 30),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Quantidade",
                                  // suffixIcon:
                                  //     Icon(Icons.card_giftcard, color: Colors.blue),
                                  fillColor: Colors.blue),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 100),
                            SizedBox(
                                width: 200.0,
                                height: 60.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {
                                    addCard(widget.cards[0], widget.binder);
                                  },
                                  child: Text('Adicionar Carta'),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]));
        });
  }
}
