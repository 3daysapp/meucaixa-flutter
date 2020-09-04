import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final Function callback;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Color color;
  DefaultTextField(
      {this.callback,
      this.obscureText = false,
      this.color = Colors.white,
      this.icon,
      @required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: callback,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          prefixIcon: icon != null ? Icon(icon) : null,
          fillColor: color,
        ),
      ),
    );
  }
}
