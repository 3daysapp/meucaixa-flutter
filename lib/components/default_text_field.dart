import 'package:flutter/material.dart';

///
///
/// TODO - Utilizar o NewDefaultTextField
@deprecated
class DefaultTextField extends StatelessWidget {
  final Function(String) callback;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType inputType;
  final String Function(String) validator;
  final TextInputAction inputAction;
  final double horizontalPadding;
  final String initialValue;
  final TextEditingController controller;

  ///
  ///
  ///
  DefaultTextField({
    this.callback,
    this.obscureText = false,
    this.icon,
    this.horizontalPadding = 20,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.initialValue,
    this.validator,
    this.controller,
    @required this.hintText,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: horizontalPadding,
      ),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: callback,
        obscureText: obscureText,
        keyboardType: inputType,
        validator: validator,
        controller: controller,
        textInputAction: inputAction,
        onFieldSubmitted: (_) => inputAction == TextInputAction.next
            ? FocusScope.of(context).nextFocus()
            : FocusScope.of(context).unfocus(),
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
