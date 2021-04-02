import 'package:flutter/material.dart';

class TextFormFileds extends StatelessWidget {
  final String hint;
  final Function save;
  final bool isPassword;
  final Function validator;
  final keywordState;
  const TextFormFileds({
    Key key,
    @required this.hint,
    @required this.save,
    this.isPassword = false,
    @required this.validator,
    this.keywordState=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        onSaved: save,
        validator: validator,
        obscureText: isPassword,
        keyboardType: keywordState ? TextInputType.number:null,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(12)),
      ),
    );
  }
}
