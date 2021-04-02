import 'package:avokadio/auth/signUp/nameAndSurnameSave.dart';
import 'package:avokadio/auth/signUp/signUpWithEmail.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SharedPreferences _sharedPreferences;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(""),
        backgroundColor: AvokadioTheme.background,
      ),
      body: Container(
        width: double.infinity,
        color: AvokadioTheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getText(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getGoogleButton(),
                getEmailButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getText() {
    return AvokadioText(
      text: "Continue With",
      color: AvokadioTheme.firstBackground,
      size: 30,
      state: true,
    );
  }

  Widget getGoogleButton() {
    return RaisedButtons(
      text: "Google",
      press: () async {
        final result = await signInWithGoogle();
        if (result) {
          _saveEmailToShared();
        }
      },
      textSize: 18,
      minWidth: 5,
    );
  }

  Widget getEmailButton() {
    return RaisedButtons(
      text: "E-mail",
      press: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpWithEmail()));
      },
      textSize: 18,
      minWidth: 5,
    );
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = userCredential.user;
      if (user != null) {
        setState(() {
          _userEmail = user.email;
        });
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {}
    }
  }

  _saveEmailToShared() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString("email", _userEmail).then((value) {
        if (value) {
          _pageRouter();
        }
      });
    } catch (e) {}
  }

  _pageRouter() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => NameAndSurnameSave()),
        (route) => false);
  }
}
