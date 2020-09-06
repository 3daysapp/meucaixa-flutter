import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/rounded_action_button.dart';
import 'package:meu_caixa_flutter/screens/caixa_screen.dart';
import 'package:meu_caixa_flutter/screens/register_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components/display_alert.dart';

class LoginScreen extends StatefulWidget {
  static String screenId = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void signIn() async {
    toggleSpinner();
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: _userEmail, password: _userPassword);
      if (user != null) {
        toggleSpinner();
        Navigator.pushNamed(context, CaixaScreen.screenId);
      } else {
        toggleSpinner();
        showAlertDialog(
            context: context,
            title: 'Erro',
            message: 'Usuário ou senha incorretos',
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]);
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
          context: context,
          title: 'Erro',
          message: 'Usuário ou senha incorretos.',
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]);
      toggleSpinner();
    } catch (e) {
      toggleSpinner();
      print(e);
    }
  }

  void toggleSpinner() {
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

  String _userEmail;
  String _userPassword;
  bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 200,
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        image: AssetImage('images/meucaixa-logo.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DefaultTextField(
                        hintText: 'Seu email',
                        inputType: TextInputType.emailAddress,
                        icon: Icons.email,
                        callback: (newValue) {
                          _userEmail = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, informe seu email';
                          }
                          return null;
                        },
                      ),
                      DefaultTextField(
                        hintText: 'Sua senha',
                        icon: Icons.vpn_key,
                        obscureText: true,
                        inputAction: TextInputAction.done,
                        callback: (newValue) {
                          _userPassword = newValue;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, informe sua senha';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                RoundedActionButton(
                  callback: () {
                    signIn();
                  },
                  label: 'Entrar',
                ),
                Text(
                  'Ainda não possui uma conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  child: Text(
                    'clique aqui para se cadastrar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.screenId);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
