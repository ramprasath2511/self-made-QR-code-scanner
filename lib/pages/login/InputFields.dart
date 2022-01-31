import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final String label;
  final IconData icon;

  InputFieldArea({this.hint, this.label, this.obscure, this.icon});

  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Color(0xFFe84c0f),
          ),
        ),
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.black,
          ),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
      ),
    ));
  }
}
