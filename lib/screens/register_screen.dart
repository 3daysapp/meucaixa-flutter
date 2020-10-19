import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  void registerUser() async {
    if (_formKey.currentState.validate()) {
      toggleSpinner();
      try {
        await auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
        User user = auth.currentUser;
        await user.updateProfile(displayName: username);
        toggleSpinner();
        Navigator.pushNamed(context, MainScreen.screenId);
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
        body: Center(
          child: SingleChildScrollView(
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DefaultTextField(
                            callback: (newValue) {
                              userEmail = newValue;
                            },
                            hintText: 'Seu e-mail',
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor, informe seu email!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          DefaultTextField(
                            callback: (newValue) {
                              userPassword = newValue;
                            },
                            hintText: 'Sua senha',
                            obscureText: true,
                            icon: Icons.vpn_key,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor, informe uma senha!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          DefaultTextField(
                            callback: (newValue) {
                              username = newValue;
                            },
                            hintText: 'Seu nome',
                            inputAction: TextInputAction.done,
                            icon: Icons.person,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor, informe seu nome!";
                              } else {
                                return null;
                              }
                            },
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
      ),
    );
  }
}
