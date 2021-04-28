import 'package:flutter/material.dart';

class AvokadioText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final bool state;
  AvokadioText(
      {Key key,
      @required this.text,
      @required this.color,
      @required this.size,
      this.state=false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        
        color: color,
        fontSize: size,
        decoration: TextDecoration.none,
        fontWeight: state ? FontWeight.bold : FontWeight.normal
      ),
    );
  }
}
