import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/rounded_action_button.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/screens/register_screen.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/display_alert.dart';

class LoginScreen extends StatefulWidget {
  static String screenId = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<SharedPreferences> _prefs;
  String _userEmail;
  String _userPassword;
  bool _showSpinner = false;
  bool saveUserEmail = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signIn() async {
    final sharedPrefs = await _prefs;
    if (_formKey.currentState.validate()) {
      _userEmail = emailController.text;
      _userPassword = passwordController.text;
      toggleSpinner();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        if (user != null) {
          if (saveUserEmail) {
            sharedPrefs.setBool('shouldSaveUserEmail', saveUserEmail);
            sharedPrefs.setString('userEmail', _userEmail);
          }
          sharedPrefs.setBool("alreadyHasUser", true);
          toggleSpinner();
          _userEmail = "";
          _userPassword = "";
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainScreen.screenId, (route) => false);
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
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefences();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _userPassword = null;
    _userPassword = null;
  }

  void loadSharedPrefences() {
    _prefs = SharedPreferences.getInstance();
    loadUserEmail();
  }

  void loadUserEmail() async {
    final sharedPrefs = await _prefs;
    setState(() {
      if (sharedPrefs.containsKey('shouldSaveUserEmail')) {
        saveUserEmail = sharedPrefs.getBool('shouldSaveUserEmail');
        if (saveUserEmail) {
          emailController.text = sharedPrefs.getString('userEmail');
        }
      }
    });
  }

  void toggleSpinner() {
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

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
                        controller: emailController,
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
                        controller: passwordController,
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Checkbox(
                        value: saveUserEmail,
                        onChanged: (newValue) async {
                          setState(() {
                            saveUserEmail = newValue;
                          });
                        },
                      ),
                    ),
                    Text('Lembrar email'),
                  ],
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
