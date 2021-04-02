import 'package:avokadio/page/signInPage.dart';
import 'package:avokadio/page/signUpPage.dart';
import 'package:avokadio/theme/exportWidget.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        color: AvokadioTheme.firstBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getImage(screenHeight, screenWidth),
            Column(
              children: [
                getGetStartedButton(),
                SizedBoxs(size: 20),
                getText(),
                getLogInButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getImage(double screenHeight, double screenWidth) {
    return Container(
      child: Image(image: AssetImage("assets/images/avokadio.png")),
      height: screenHeight / 3,
      width: screenWidth / (2 / 3),
    );
  }

  Widget getGetStartedButton() {
    return RaisedButtons(
      text: "GET STARTED",
      color: true,
      press: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      textColor: true,
      textSize: 18,
      minWidth: 3,
    );
  }

  Widget getLogInButton() {
    return RaisedButtons(
      text: "LOG IN",
      color: true,
      press: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInPage()));
      },
      textColor: true,
      textSize: 18,
      minWidth: 3,
    );
  }


  Widget getText() {
    return AvokadioText(
      text: "Already have an account",
      color: AvokadioTheme.background,
      size: 18,
    );
  }
}
