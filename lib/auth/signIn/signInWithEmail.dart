import 'package:avokadio/page/routerPage.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignInWithEmail extends StatefulWidget {
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
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
            SizedBoxs(
              size: 35,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: getEmailText(),
                        ),
                        Expanded(
                          flex: 5,
                          child: getEmailTextFormField(),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxs(
                    size: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: getPasswordText(),
                        ),
                        Expanded(
                          flex: 5,
                          child: getPasswordTextFormField(),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxs(
                    size: 15,
                  ),
                  getSignInButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getText() {
    return AvokadioText(
      text: "Sıgn In With Email",
      color: AvokadioTheme.firstBackground,
      size: 30,
      state: true,
    );
  }

  Widget getEmailText() {
    return AvokadioText(
      text: "Email: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getPasswordText() {
    return AvokadioText(
      text: "Password: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getEmailTextFormField() {
    return TextFormFileds(
      hint: "E-mail",
      save: (String value) {
        setState(() {
          _email = value;
        });
      },
      validator: (String value) {
        if (!value.contains("@")) {
          return "Lütfen geçerli email giriniz";
        }
        return null;
      },
    );
  }

  Widget getPasswordTextFormField() {
    return TextFormFileds(
      hint: "Password",
      save: (String value) {
        setState(() {
          _password = value;
        });
      },
      validator: (String value) {
        if (value.length < 6) {
          return "Şifre 6 karakterden fazla olmalı";
        }
        return null;
      },
      isPassword: true,
    );
  }

  Widget getSignInButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 5),
      child: RaisedButtons(
        text: "Sign In",
        press: controler,
        textSize: 18,
      ),
    );
  }

  controler() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _signInWithEmailState();
    }
  }

  _signInWithEmailState() async {
    if (_auth.currentUser == null) {
      try {
        User user = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        if (user.email != null) {
          _saveToEmail();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {}
      }
    }
  }

  _saveToEmail() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString("email", _email).then((value) {
      if (value) {
        _pageRouter();
      }
    });
  }

  _pageRouter() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => RouterPage()),
        (route) => false);
  }
}
