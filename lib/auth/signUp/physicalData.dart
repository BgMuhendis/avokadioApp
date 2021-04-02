import 'package:avokadio/auth/signUp/genderInfo.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhysicalData extends StatefulWidget {
  @override
  _PhysicalDataState createState() => _PhysicalDataState();
}

class _PhysicalDataState extends State<PhysicalData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _weight, _height;
  SharedPreferences _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                          child: getWeightText(),
                        ),
                        Expanded(
                          flex: 5,
                          child: getWeigthField(),
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
                          child: getHeightText(),
                        ),
                        Expanded(
                          flex: 5,
                          child: getHeightField(),
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
      text: " Fiziksel Veriler",
      color: AvokadioTheme.firstBackground,
      size: 28,
      state: true,
    );
  }

  Widget getWeightText() {
    return AvokadioText(
      text: "Weight: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getHeightText() {
    return AvokadioText(
      text: "Height: ",
      color: AvokadioTheme.firstBackground,
      size: 20,
      state: true,
    );
  }

  Widget getWeigthField() {
    return TextFormFileds(
      hint: "Weight",
      save: (String value) {
        setState(() {
          _weight = int.parse(value);
        });
      },
      validator: (String value) {
        if (value.length < 1) {
          return "Lütfen geçerli bir değer giriniz";
        }
        return null;
      },
      keywordState: true,
    );
  }

  Widget getHeightField() {
    return TextFormFileds(
      hint: "Height",
      save: (String value) {
        setState(() {
          _height = int.parse(value);
        });
      },
      validator: (String value) {
        if (value.length < 1) {
          return "Lütfen geçerli bir değer giriniz";
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
      _physicalDataSaveToShared();
    }
  }

  _physicalDataSaveToShared() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setInt("weight", _weight);
    _sharedPreferences.setInt("height", _height);
    _pageRouter();
  }
  _pageRouter(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GenderData()));
  }
}
