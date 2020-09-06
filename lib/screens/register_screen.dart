import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/caixa_screen.dart';
import '../components/rounded_action_button.dart';
import '../components/default_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../contantes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static String screenId = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void registerUser() async {
    toggleSpinner();
    try {
      await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      User user = auth.currentUser;
      await user.updateProfile(displayName: username);
      toggleSpinner();
      Navigator.pushNamed(context, CaixaScreen.screenId);
    } on FirebaseAuthException catch (e) {
      toggleSpinner();
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      toggleSpinner();
      print(e);
    }
  }

  void toggleSpinner() {
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  String userEmail;
  String userPassword;
  String username;
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
                        callback: (newValue) {
                          userEmail = newValue;
                        },
                        color: Colors.white,
                        hintText: 'Seu e-mail',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                      ),
                      DefaultTextField(
                        callback: (newValue) {
                          userPassword = newValue;
                        },
                        color: Colors.white,
                        hintText: 'Sua senha',
                        obscureText: true,
                        icon: Icons.vpn_key,
                      ),
                      DefaultTextField(
                        callback: (newValue) {
                          username = newValue;
                        },
                        color: Colors.white,
                        hintText: 'Seu nome',
                        icon: Icons.person,
                      ),
                      RoundedActionButton(
                        color: Colors.green,
                        label: 'Cadastrar',
                        callback: () {
                          print('Clicou no botão');
                          setState(() {
                            registerUser();
                          });
                        },
                      ),
                      RoundedActionButton(
                        color: kRadicalRedColor,
                        label: 'Cancelar',
                        callback: () {
                          Navigator.pop(context);
                        },
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
