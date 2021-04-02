import 'package:avokadio/page/loginPage.dart';
import 'package:avokadio/theme/themeColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  SharedPreferences _sharedPreferences;
  String _name;
  int _weight;
  bool state = false;
  String _email;
  bool isUserSignIn;
  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _signInControl();
  }

  _signInControl() async {
    await _googleSignIn.isSignedIn().then((value) {
      setState(() {
        isUserSignIn = value;
      });
    });
  }

  _getUserInfo() async {
    _email = await _getEmailInfo();
    var documents = await _firestore
        .collection("users")
        .where("email", isEqualTo: _email)
        .get();
    if (documents.docs != null) {
      setState(() {
        state = true;
      });
      for (var item in documents.docs) {
        setState(() {
          _name = item.data()["name"];
          _weight = item.data()["weight"];
        });
      }
    } else {
      state = false;
    }
  }

  _getEmailInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AvokadioTheme.background,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _loginControl(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            height: screenHeight / 3,
            width: screenWidth * 2 / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AvokadioTheme.background),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state
                    ? Center(child: _getText())
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AvokadioTheme.firstBackground,
                        ),
                      )),
          ),
        ));
  }

  Widget _getText() {
    return Text(
      "Merhaba " + _name + " ,\n" + "Güncel kilon: " + _weight.toString(),
      style: TextStyle(
        color: AvokadioTheme.firstBackground,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _loginControl(BuildContext context) async {
    if (_auth.currentUser != null) {
      _auth.signOut();
      _clearSharedPreferences();
      _pageRouter();
    }
    if (isUserSignIn) {
      await _googleSignIn.signOut().then((value) {
        _clearSharedPreferences();
        _pageRouter();
      });
    }
  }

  _clearSharedPreferences() {
    _sharedPreferences.clear();
    _sharedPreferences.commit();
  }

  _pageRouter() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => FirstPage()),
        (route) => false);
  }
}
