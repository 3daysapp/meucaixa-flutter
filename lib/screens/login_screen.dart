import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/contantes.dart';

class LoginScreen extends StatelessWidget {
  static String screenId = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: kRichBlackColor,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/meucaixa-logo.png'),
                  ),
                ),
              ),
              DefaultTextField(
                hintText: 'Seu email',
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
                callback: (newValue) {},
              ),
              DefaultTextField(
                hintText: 'Sua senha',
                icon: Icons.email,
                obscureText: true,
                callback: (newValue) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
