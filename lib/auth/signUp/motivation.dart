import 'package:avokadio/auth/signUp/physicalData.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Motivation extends StatefulWidget {
  @override
  _MotivationState createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
  List<String> _motivayon = ["LOSE WEIGHT", "GAIN MUCSLE", "WELLNESS"];
  SharedPreferences _sharedPreferences;
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
              size: 130,
            ),
            _builListView(),
          ],
        ),
      ),
    );
  }

  Widget getText() {
    return AvokadioText(
      text: " What is your primary \n motivation of installing \n this app",
      color: AvokadioTheme.firstBackground,
      size: 30,
      state: true,
    );
  }

  ListView _builListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _motivayon.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 5),
          child: RaisedButtons(
            text: _motivayon[index],
            press: () => _motivationSaveToShared(_motivayon[index]),
            textSize: 18,
          ),
        );
      },
    );
  }

  _motivationSaveToShared(String text) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString("motivation", text).then((value) => {
          if (value)
            {
              _pageRouter(),
            }
        });
  }

  _pageRouter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PhysicalData()));
  }
}
