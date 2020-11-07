import 'package:flutter/material.dart';

/// TODO coloquei esse nome para nao interfirir no default que ja existe, depois
/// podemos renomear esse e eliminar o outro
class NewDefaultTextField extends StatelessWidget {
  final String initialValue;
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final bool isPassword;

  ///
  ///
  ///
  NewDefaultTextField({
    this.initialValue,
    this.controller,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.isPassword = false,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
          labelText: labelText,
        ),
        initialValue: initialValue,
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
