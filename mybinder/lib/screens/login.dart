import 'package:flutter/material.dart';
import 'package:mybinder/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybinder/notification_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _iconAnimation;
  late AnimationController _iconAnimationController;
  late String _email, _password;
  bool signInEmail = false;
  String emailButtonText = "Entrar com email";
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
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

  void changeEmailState() {
    setState(() {
      signInEmail = !signInEmail;
      emailButtonText = 'Entrar';
    });
  }

  void loginEmail() async {
    try {
      var authUser = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      goToHome(authUser);
    } on FirebaseAuthException catch (e) {
      showErrorToast("Email ou Senha incorretos");
    }
  }

  void goToHome(user) {
    if (user != null) {
      final NotificationHandler topic = new NotificationHandler();
      topic.init();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  user: '',
                )),
      );
    }
  }

  showErrorToast(String errorMessage) {
    final snackBar = SnackBar(
      content: Text('$errorMessage'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print(googleAuth.toString());

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("Creds: " + credential.toString());

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
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                        height: 150,
                        width: 150,
                        child: FittedBox(
                          child: new Image(
                            image: new AssetImage("assets/logo.png"),
                            fit: BoxFit.fill,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130.0,
                          height: 150,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'Agne',
                            ),
                            textAlign: TextAlign.center,
                            child: AnimatedTextKit(
                              repeatForever: false,
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TypewriterAnimatedText('A sua pasta de Magic'),
                                TypewriterAnimatedText('Onde estiver'),
                                TypewriterAnimatedText('MyBinder'),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                //SizedBox(height: 10),
                new Container(
                  //padding: const EdgeInsets.all(40.0),
                  child: new Form(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width: 200,
                            child: Column(children: [
                              if (signInEmail)
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "E-mail cadastrado",
                                      labelStyle: new TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                      suffixIcon:
                                          Icon(Icons.email, color: Colors.blue),
                                      fillColor: Colors.blue),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value.trim();
                                    });
                                  },
                                  style: new TextStyle(fontSize: 10),
                                ),
                              SizedBox(height: 10),
                              if (signInEmail)
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelStyle: new TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                      labelText: "Senha",
                                      suffixIcon:
                                          Icon(Icons.lock, color: Colors.blue)),
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  },
                                ),
                            ])),

                        SizedBox(height: 30),
                        SignInButtonBuilder(
                          text: '$emailButtonText',
                          icon: Icons.email,
                          onPressed: () {
                            if (signInEmail == false) {
                              changeEmailState();
                            } else {
                              loginEmail();
                            }
                          },
                          backgroundColor: Colors.blue,
                        ),
                        SignInButton(
                          Buttons.GoogleDark,
                          text: "Entrar com Google",
                          onPressed: () {
                            Future<UserCredential> auth = signInWithGoogle();
                            goToHome(auth);
                          },
                        ),
                        //SizedBox(height: 15),
                        new MaterialButton(
                            height: 35,
                            minWidth: 220,
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            child: Text('Criar conta',
                                style: TextStyle(fontSize: 20)),
                            onPressed: () async {
                              if (signInEmail == false) {
                                changeEmailState();
                              } else {
                                try {
                                  await auth.createUserWithEmailAndPassword(
                                      email: _email, password: _password);
                                  goToHome(auth);
                                } catch (e) {
                                  showErrorToast("Email ou Senha inválidos");
                                }
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
