import 'package:flutter/material.dart';
import 'package:connectmasjid/results_screen/GoogleDone.dart';
import 'package:connectmasjid/main_screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:validators/validators.dart' as validator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectmasjid/main_screens/NavigationUser.dart';

class RegisterPage extends StatefulWidget {
  static String id = '/RegisterPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name;
  String email;
  String password;
  bool isAdmin;
  bool _showSpinner = false;
  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await _handleSignIn();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoogleDone(user, _googleSignIn)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
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
                    style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold ,color: Colors.purple),
                  ),
                   ],
                  ),

                  Column(
                    children: [
                      TextField(
                       // keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          labelText: 'Full Name',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _wrongEmail ? _emailText : null,
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
                          labelText: 'Password',
                          errorText: _wrongPassword ? _passwordText : null,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Color(0xff447def),
                    onPressed: () async {
                      setState(() {
                        _wrongEmail = false;
                        _wrongPassword = false;
                      });
                      try {
                        if (validator.isEmail(email) &
                            validator.isLength(password, 6)) {
                          setState(() {
                            _showSpinner = true;
                          });
                          final newUser = FirebaseAuth.instance
                          .createUserWithEmailAndPassword( email: email, password: password)
                          .then((signedInUser) {
                      FirebaseAuth.instance.currentUser().then((user) {
                        storeNewUser(email,name,user.uid);
                      }).catchError((e) {
                      print(e);
                      }).catchError((e) {
                      print(e);
                      });
                      });

                          if (newUser != null) {
                            print('user authenticated by registration');
                            Navigator.pushNamed(context, NavigationUser.id);
                          }
                        }

                        setState(() {
                          if (!validator.isEmail(email)) {
                            _wrongEmail = true;
                          } else if (!validator.isLength(password, 6)) {
                            _wrongPassword = true;
                          } else {
                            _wrongEmail = true;
                            _wrongPassword = true;
                          }
                        });
                      } catch (e) {
                        setState(() {
                          _wrongEmail = true;
                          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                            _emailText =
                                'The email address is already in use by another account';
                          }
                        });
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        child: Text(
                          ' Sign In',
                          style: TextStyle(fontSize: 22.0, color: Colors.blue),
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
    );
  }

  void storeNewUser(String email, String name, String uid,) {
    bool isAdmin = false;
    Firestore.instance.collection('user').document(uid).setData({
      'Email': email,
      'uid': uid,
      'Name': name,
      'isAdmin' : isAdmin,
    }).then((value) {
      print("syek");
    }).catchError((e) {
      print(e.toString());
    });
  }
}