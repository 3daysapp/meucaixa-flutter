import 'package:flutter/material.dart';
import '../contantes.dart';

class RegisterScreen extends StatelessWidget {
  static String screenId = 'register_screen';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kRichBlackColor,
      child: SizedBox(
        height: 150,
        width: 150,
        child: Hero(
          tag: 'logo',
          child: Image(
            image: AssetImage('images/meucaixa-logo.png'),
          ),
        ),
      ),
    );
  }
}
