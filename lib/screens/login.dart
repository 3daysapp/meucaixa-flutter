import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
enum LoginStatus {
  init,
  form,
  auth,
  go,
}

///
///
///
class Login extends StatefulWidget {
  ///
  ///
  ///
  final bool logoff;
  const Login({Key key, this.logoff = false}) : super(key: key);

  ///
  ///
  ///
  @override
  _LoginState createState() => _LoginState();
}

///
///
///
class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StreamController<LoginStatus> _controller =
      StreamController<LoginStatus>();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    // TODO - Shared Preferences.
    bool automaticLogin = await _shouldAutomaticalyLogin();
    if (automaticLogin &&
        (_auth.currentUser != null || widget.logoff == false)) {
      _controller.add(LoginStatus.go);
    } else {
      _controller.add(LoginStatus.form);
    }
  }

  ///
  ///
  ///
  Future<bool> _shouldAutomaticalyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('automaticLogin')) {
      return await prefs.getBool('automaticLogin');
    }
    return false;
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Caixa'),
        centerTitle: true,
      ),
      body: StreamBuilder<LoginStatus>(
        stream: _controller.stream,
        initialData: LoginStatus.init,
        builder: (BuildContext context, AsyncSnapshot<LoginStatus> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data) {

              /// Init
              case LoginStatus.init:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Iniciando...'),
                      ),
                    ],
                  ),
                );

              /// Form
              case LoginStatus.form:
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          /// Logo
                          Image.asset(
                            'images/meucaixa-logo.png',
                            height: 250,
                          ),

                          /// E-mail
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(),
                                counterText: '',
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) =>
                                  EmailValidator.validate(value)
                                      ? null
                                      : 'Informe o e-mail.',
                            ),
                          ),

                          /// Password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                                counterText: '',
                              ),
                              controller: _passwordController,
                              obscureText: true,
                              validator: (String value) =>
                                  value.isEmpty ? 'Informe a senha.' : null,
                            ),
                          ),

                          RaisedButton(
                            child: Text('ENTRAR'),
                            onPressed: _login,
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              /// Auth
              case LoginStatus.auth:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Autenticando...'),
                      ),
                    ],
                  ),
                );

              /// Go
              case LoginStatus.go:
                _goAhead(context);

                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Iniciando...'),
                      ),
                    ],
                  ),
                );
            }
          }

          return Center(
            child: Text('No Data!'),
          );
        },
      ),
    );
  }

  ///
  ///
  ///
  void _login() async {
    if (_formKey.currentState.validate()) {
      _controller.add(LoginStatus.auth);

      String email = _emailController.text;
      String pass = _passwordController.text;

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);

        if (user == null) {
          throw Exception('Usuário nulo.');
        }

        _controller.add(LoginStatus.go);
      } catch (e) {
        print(e);
        await DisplayAlert.show(
          context: context,
          title: 'Atenção',
          message: 'Usuário e/ou senha incorretos.',
        );
        _controller.add(LoginStatus.form);
      }
    }
  }

  ///
  ///
  ///
  void _goAhead(BuildContext context) async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<MainScreen>(
          builder: (BuildContext context) => MainScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
