import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/utils/config.dart';

/// TODO coloquei esse nome para nao interfirir no default que ja existe, depois
/// podemos renomear esse e eliminar o outro
class NewDefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Function validator;
  final bool isPassword;
  final Config _config = Config();
  NewDefaultTextField(
      {this.controller,
      this.validator,
      this.keyboardType,
      this.labelText,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: _config.textFieldDecoration.copyWith(labelText: labelText),
        obscureText: isPassword,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
