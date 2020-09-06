import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final Function callback;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType inputType;
  final Function validator;
  final TextInputAction inputAction;
  DefaultTextField(
      {this.callback,
      this.obscureText = false,
      this.icon,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.validator = null,
      @required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        onChanged: callback,
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        textInputAction: inputAction,
        onFieldSubmitted: (_) => {
          if (inputAction == TextInputAction.next)
            {
              FocusScope.of(context).nextFocus(),
            }
          else
            {
              FocusScope.of(context).unfocus(),
            }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
