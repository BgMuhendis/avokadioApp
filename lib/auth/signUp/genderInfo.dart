import 'package:avokadio/auth/signUp/signUpWithEmail.dart';
import 'package:avokadio/page/routerPage.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenderData extends StatefulWidget {
  @override
  _GenderDataState createState() => _GenderDataState();
}

class _GenderDataState extends State<GenderData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _genderText = ["Male", "Female"];
  SharedPreferences _sharedPreferences;
  String _collection = "users";
  String _name, _surName, _birthDay, _email, _motivation, _gender;
  int _weight, _height;
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _name = _sharedPreferences.getString("name");
    _surName = _sharedPreferences.getString("surname");
    _birthDay = _sharedPreferences.getString("birthday");
    _email = _sharedPreferences.getString("email");
    _motivation = _sharedPreferences.getString("motivation");
    _weight = _sharedPreferences.getInt("weight");
    _height = _sharedPreferences.getInt("height");
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: _getText(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _getMaleButton(),
                _getFemaleButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getText() {
    return AvokadioText(
      text: " What is your biological \n gender",
      color: AvokadioTheme.firstBackground,
      size: 30,
      state: true,
    );
  }

  Widget _getMaleButton() {
    return RaisedButtons(
      text: _genderText[0],
      press: () => _genderSave(_genderText[0]),
      textSize: 18,
      minWidth: 5,
    );
  }

  Widget _getFemaleButton() {
    return RaisedButtons(
      text: _genderText[1],
      press: () => _genderSave(_genderText[1]),
      textSize: 18,
      minWidth: 5,
    );
  }

  _genderSave(String gender) async {
    _gender = gender;
    _saveDataFirestore();
  }

  _saveDataFirestore() async {
    _firestore.collection(_collection).add({
      'name': _name,
      'surname': _surName,
      "email": _email,
      "birthday": _birthDay,
      "motivation": _motivation,
      "gender": _gender,
      "weight": _weight,
      "height": _height
    }).then((value) => _pageRouter());
  }

  _pageRouter() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => RouterPage()),
        (route) => false);
  }
}
