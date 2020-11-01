import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/rounded_action_button.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
///
///
class RegisterScreen extends StatefulWidget {
  static String screenId = 'register_screen';

  const RegisterScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

///
///
///
class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userEmail;
  String userPassword;
  String username;
  bool showSpinner = false;

  ///
  ///
  ///
  void registerUser() async {
    if (_formKey.currentState.validate()) {
      toggleSpinner();
      try {
        await auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
        User user = auth.currentUser;
        await user.updateProfile(displayName: username);
        toggleSpinner();

        await Navigator.pushNamed(context, MainScreen.screenId);
      } on FirebaseAuthException catch (e) {
        toggleSpinner();
        if (e.code == 'weak-password') {
        } else if (e.code == 'email-already-in-use') {}
      } catch (e) {
        toggleSpinner();
        print(e);
      }
    }
  }

  ///
  ///
  ///
  void toggleSpinner() {
    /// Caso clássico de utilização de stream.
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DefaultTextField(
                          callback: (String newValue) {
                            userEmail = newValue;
                          },
                          hintText: 'Seu e-mail',
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validator: (String value) => value.isEmpty
                              ? 'Por favor, informe seu email!'
                              : null,
                        ),
                        DefaultTextField(
                          callback: (String newValue) =>
                              userPassword = newValue,
                          hintText: 'Sua senha',
                          obscureText: true,
                          icon: Icons.vpn_key,

                          /// TODO - Pode melhorar a legibilidade.
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, informe uma senha!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        DefaultTextField(
                          callback: (String newValue) => username = newValue,
                          hintText: 'Seu nome',
                          inputAction: TextInputAction.done,
                          icon: Icons.person,
                          validator: (String value) => value.isEmpty
                              ? 'Por favor, informe seu nome!'
                              : null,
                        ),
                      ],
                    ),
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
          ),
        ),
      ),
    );
  }
}
