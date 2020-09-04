import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/rounded_action_button.dart';
import '../components/default_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../contantes.dart';

class RegisterScreen extends StatefulWidget {
  static String screenId = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            color: kRichBlackColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('images/meucaixa-logo.png'),
                    ),
                  ),
                ),
                Text(
                  'Meu Caixa - Cadastro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DefaultTextField(
                        callback: (newValue) {},
                        color: Colors.white,
                        hintText: 'Seu e-mail',
                        icon: Icons.email,
                      ),
                      DefaultTextField(
                        callback: (newValue) {},
                        color: Colors.white,
                        hintText: 'Sua senha',
                        obscureText: true,
                        icon: Icons.vpn_key,
                      ),
                      DefaultTextField(
                        callback: (newValue) {},
                        color: Colors.white,
                        hintText: 'Seu nome',
                        obscureText: true,
                        icon: Icons.person,
                      ),
                      RoundedActionButton(
                        color: Colors.green,
                        label: 'Cadastrar',
                        callback: () {
                          print('Clicou no botão');
                          setState(() {
                            showSpinner = true;
                          });
                        },
                      ),
                      RoundedActionButton(
                        color: kRadicalRedColor,
                        label: 'Cancelar',
                        callback: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
