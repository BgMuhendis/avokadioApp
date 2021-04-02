import 'package:avokadio/auth/signIn/signInWithEmail.dart';
import 'package:avokadio/page/routerPage.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _userEmail;
  SharedPreferences _sharedPreferences;
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
      text: "LOG IN",
      color: AvokadioTheme.firstBackground,
      size: 30,
      state: true,
    );
  }

  Widget getGoogleButton() {
    return RaisedButtons(
      text: "Google",
      press: _signInWithGoogle,
      textSize: 18,
      minWidth: 5,
    );
  }

  Widget getEmailButton() {
    return RaisedButtons(
      text: "E-Mail",
      press: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInWithEmail()));
      },
      textSize: 18,
      minWidth: 5,
    );
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      setState(() {
        _userEmail = googleUser.email;
      });
      _saveEmailToShared();
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
        MaterialPageRoute(builder: (BuildContext context) => RouterPage()),
        (route) => false);
  }
}
