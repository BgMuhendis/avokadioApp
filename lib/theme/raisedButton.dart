import 'package:avokadio/theme/themeColor.dart';
import 'package:flutter/material.dart';
import 'appText.dart';

class RaisedButtons extends StatelessWidget {
  final String text;
  final Function press;
  final bool color, textColor;
  final double textSize;
  final int minWidth;
  const RaisedButtons({
    Key key,
   @required this.text,
   @required this.press,
    this.color=false,
    this.textColor=false,
   @required this.textSize,
    this.minWidth=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ButtonTheme(
      minWidth: minWidth!=0 ? screenWidth * 2 / minWidth:screenWidth,
      child: RaisedButton(
        onPressed: press,
        color: color ? AvokadioTheme.background : AvokadioTheme.firstBackground,
        child: AvokadioText(
          text: text,
          color: textColor ? AvokadioTheme.firstBackground : AvokadioTheme.background,
          size: textSize,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
