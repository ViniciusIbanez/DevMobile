import 'package:flutter/material.dart';
import 'package:mybinder/screens/mybinder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  String _email, _password;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black,
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
                SizedBox(height: 100),
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
                              labelText: "E-mail cadastrado",
                              suffixIcon: Icon(Icons.email, color: Colors.blue),
                              fillColor: Colors.blue),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Senha",
                              suffixIcon: Icon(Icons.lock, color: Colors.blue)),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 100),
                        new MaterialButton(
                          height: 50.0,
                          minWidth: 300,
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text('Entrar', style: TextStyle(fontSize: 25)),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MyBinder()),
                            // );
                            Future<UserCredential> auth = signInWithGoogle();
                          },
                        ),
                        SizedBox(height: 15),
                        new MaterialButton(
                            height: 50.0,
                            minWidth: 300,
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            child: Text('Criar conta',
                                style: TextStyle(fontSize: 25)),
                            onPressed: () {
                              try {
                                auth.createUserWithEmailAndPassword(
                                    email: _email, password: _password);
                              } catch (e) {
                                print("Error on signup " + e);
                              }
                            }),
                        new Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
