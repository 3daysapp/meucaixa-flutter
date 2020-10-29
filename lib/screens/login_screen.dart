import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/rounded_action_button.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/screens/register_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
class LoginScreen extends StatefulWidget {
  static String screenId = 'login_screen';

  const LoginScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///
///
///
class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<SharedPreferences> _prefs;
  String _userEmail;
  String _userPassword;
  bool _showSpinner = false;
  bool saveUserEmail = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
  }

  ///
  ///
  ///
  void signIn() async {
    final SharedPreferences sharedPrefs = await _prefs;
    if (_formKey.currentState.validate()) {
      _userEmail = emailController.text;
      _userPassword = passwordController.text;
      toggleSpinner();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
        if (user != null) {
          if (saveUserEmail) {
            await sharedPrefs.setBool('shouldSaveUserEmail', saveUserEmail);
            await sharedPrefs.setString('userEmail', _userEmail);
          }

          await sharedPrefs.setBool('alreadyHasUser', true);

          toggleSpinner();

          _userEmail = '';

          _userPassword = '';

          await Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.screenId,
            (Route<dynamic> route) => false,
          );
        } else {
          toggleSpinner();

          await DisplayAlert.show(
            context: context,
            title: 'Erro',
            message: 'Usuário ou senha incorretos.',
          );
        }
      } on FirebaseAuthException {
        await DisplayAlert.show(
          context: context,
          title: 'Erro',
          message: 'Usuário ou senha incorretos.',
        );

        toggleSpinner();
      } catch (e) {
        toggleSpinner();
        print(e);
      }
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _userPassword = null;
    _userPassword = null;
  }

  ///
  ///
  ///
  void loadSharedPreferences() {
    _prefs = SharedPreferences.getInstance();
    loadUserEmail();
  }

  ///
  ///
  ///
  void loadUserEmail() async {
    final SharedPreferences sharedPrefs = await _prefs;
    setState(() {
      if (sharedPrefs.containsKey('shouldSaveUserEmail')) {
        saveUserEmail = sharedPrefs.getBool('shouldSaveUserEmail');
        if (saveUserEmail) {
          emailController.text = sharedPrefs.getString('userEmail');
        }
      }
    });
  }

  ///
  ///
  ///
  void toggleSpinner() {
    /// TODO - Caso clássico em que deve ser utilizado um stream.
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

  ///
  ///
  ///
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
              children: <Widget>[
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
                    children: <Widget>[
                      DefaultTextField(
                        hintText: 'Seu email',
                        inputType: TextInputType.emailAddress,
                        icon: Icons.email,
                        controller: emailController,
                        // TODO - Operador ternário.
                        validator: (String value) {
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
                        // TODO - Operador ternário.
                        validator: (String value) {
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
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Checkbox(
                        value: saveUserEmail,
                        onChanged: (bool newValue) async {
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
