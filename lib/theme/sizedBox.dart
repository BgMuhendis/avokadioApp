import 'package:flutter/material.dart';

class SizedBoxs extends StatelessWidget {
  final double size;
  final bool state;

  const SizedBoxs({Key key, @required this.size, this.state=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: state ? size : 0,
      width: !state ? size: 0,
    );
  }
}
