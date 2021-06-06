import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/screens/home.dart';
import 'package:mybinder/binder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddCard extends StatefulWidget {
  List<Binder> cards;
  List<Binder> binder;
  AddCard({Key? key, required this.cards, required this.binder})
      : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dropdownValue = '1';
  bool shouldRetrieveCards = true;
  final TextEditingController _typeAheadController = TextEditingController();
  late Binder _cardToAdd;

  @override
  initState() {
    super.initState();
  }

  Future<bool> addCard(Binder card, List<Binder> binder) async {
    binder.add(card);
    api.insertCard(auth.currentUser!.uid, card.multiverseId);
    return true;
  }

  // Future<bool> retrieveAllCards(List<Binder> cards) async {
  //   bool response = true;
  //   if (shouldRetrieveCards) {
  //     shouldRetrieveCards = false;
  //     response = await api.retrieveAllCards(cards);
  //   }

  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(fit: StackFit.expand, children: <Widget>[
      new Theme(
        data: new ThemeData(
            brightness: Brightness.dark,
            inputDecorationTheme: new InputDecorationTheme(
              hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
              labelStyle: new TextStyle(color: Colors.blue, fontSize: 25.0),
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
                      Container(
                          child: TypeAheadField<Binder?>(
                        debounceDuration: Duration(microseconds: 500),
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this._typeAheadController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: 'Search Username',
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await api.retrieveAllCards(
                              widget.cards, pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          final card = suggestion!;

                          return ListTile(
                            title: Text(card.cardName),
                          );
                        },
                        onSuggestionSelected: (Binder? suggestion) {
                          final card = suggestion!;
                          this._typeAheadController.text = card.cardName;
                          _cardToAdd = card;
                        },
                      )),
                      SizedBox(height: 30),
                      SizedBox(height: 100),
                      SizedBox(
                          width: 200.0,
                          height: 60.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              print(_cardToAdd);
                              bool response =
                                  await addCard(_cardToAdd, widget.binder);
                              final snackBar = SnackBar(
                                content: Text(_cardToAdd.cardName +
                                    " Adicionado com sucesso"),
                                backgroundColor: Colors.green,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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
  }
}
