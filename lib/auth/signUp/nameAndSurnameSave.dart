import 'package:avokadio/auth/signUp/motivation.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameAndSurnameSave extends StatefulWidget {
  @override
  _NameAndSurnameSaveState createState() => _NameAndSurnameSaveState();
}

class _NameAndSurnameSaveState extends State<NameAndSurnameSave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _surName, _birthDay;
  SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: getText(),
            ),
            SizedBoxs(
              size: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: getBirthDayText(),
                        ),
                        Expanded(
                          flex: 5,
                          child: getBirthDayTextFormField(),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxs(
                    size: 15,
                  ),
                  getNameAndSurnameSaveButton()
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
      text:
          " Welcome to Avokadio\n Community.\n We are here to giive you\n science backed wellness\n and nutrition advice\n based on your\n daily routine",
      color: AvokadioTheme.firstBackground,
      size: 28,
      state: true,
    );
  }

  Widget getEmailText() {
    return AvokadioText(
      text: "Name: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getBirthDayText() {
    return AvokadioText(
      text: "Birthday: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getPasswordText() {
    return AvokadioText(
      text: "Surname: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getEmailTextFormField() {
    return TextFormFileds(
      hint: "Name",
      save: (String value) {
        setState(() {
          _name = value;
        });
      },
      validator: (String value) {
        if (value.length < 1) {
          return "isim 1 karakterden az olamaz";
        }
        return null;
      },
    );
  }

  Widget getPasswordTextFormField() {
    return TextFormFileds(
      hint: "Surname",
      save: (String value) {
        setState(() {
          _surName = value;
        });
      },
      validator: (String value) {
        if (value.length < 1) {
          return "soyisim 1 karakterden az olamaz";
        }
        return null;
      },
    );
  }

  Widget getBirthDayTextFormField() {
    return TextFormFileds(
      hint: "Birthday",
      save: (String value) {
        setState(() {
          _birthDay = value;
        });
      },
      validator: (String value) {
        if (value.length < 6) {
          return "Doğum tarihinizi lütfen doğru giriniz";
        }
        return null;
      },
      keywordState: true,
    );
  }

  Widget getNameAndSurnameSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 5),
      child: RaisedButtons(
        text: "NEXT",
        press: _validateControl,
        textSize: 18,
      ),
    );
  }

  _validateControl() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _saveToSharedPrefences();
    }
  }

  _saveToSharedPrefences() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString("name", _name);
      _sharedPreferences.setString("surname", _surName);
      _sharedPreferences.setString("birthday", _birthDay);
      _pageRouter();
    } catch (e) {}
  }

  _pageRouter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Motivation()));
  }
}
