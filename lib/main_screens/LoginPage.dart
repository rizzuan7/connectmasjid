import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectmasjid/main_screens/NavigationUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectmasjid/results_screen/ForgotPassword.dart';
import 'package:connectmasjid/results_screen/GoogleDone.dart';
import 'package:connectmasjid/main_screens/RegisterPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:connectmasjid/main_screens/Navigation.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;
FirebaseUser _user;

class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool _showSpinner = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    // hold the instance of the authenticated user
    //    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      _user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      _user = (await _auth.signInWithCredential(credential)).user;
    }

    return _user;
  }

  void onGoogleSignIn(BuildContext context) async {
    setState(() {
      _showSpinner = true;
    });

    FirebaseUser user = await _handleSignIn();

    setState(() {
      _showSpinner = true;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoogleDone(user, _googleSignIn)));
  }

  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit the app?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => exit(0),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          color: Colors.blueAccent,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/masjid.png',
                        width: 250.0, height: 140.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Connecting Masjid',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            errorText: _wrongEmail ? emailText : null,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            errorText: _wrongPassword ? passwordText : null,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, ForgotPassword.id);
                            },
                            child: Text(
                              'Forgot Password?',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Color(0xff447def),
                      onPressed: () async {
                        setState(() {
                          _showSpinner = true;
                        });
                        try {
                          setState(() {
                            _wrongEmail = false;
                            _wrongPassword = false;
                          });
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            CheckAdmin();
                          } else {
                            print("Failed");
                          }
                        } catch (e) {
                          print(e.code);
                          if (e.code == 'ERROR_WRONG_PASSWORD') {
                            setState(() {
                              _wrongPassword = true;
                            });
                          } else {
                            setState(() {
                              emailText = 'User doesn\'t exist';
                              passwordText = 'Please check your email';
                              _wrongPassword = true;
                              _wrongEmail = true;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 22.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            ' Sign Up',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CheckAdmin() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    if (result.data['isAdmin'] == true) {
      Navigator.pushNamed(context, Navigation.id);
    } else if (result.data['isAdmin'] == false) {
      Navigator.pushNamed(context, NavigationUser.id);
    } else {
      print("Not Working");
    }
  }
}
