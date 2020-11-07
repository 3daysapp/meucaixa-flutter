import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/logo.dart';
import 'package:meu_caixa_flutter/components/new_default_textfield.dart';
import 'package:meu_caixa_flutter/models/app_user.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
///
///
enum RegisterStatus {
  form,
  register,
  go,
}

///
///
///
class RegisterScreen extends StatefulWidget {
  static String screenId = 'register_screen';

  ///
  ///
  ///
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final StreamController<RegisterStatus> _controller =
      StreamController<RegisterStatus>();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _controller.add(RegisterStatus.form);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<RegisterStatus>(
          stream: _controller.stream,
          builder: (
            BuildContext context,
            AsyncSnapshot<RegisterStatus> snapshot,
          ) {
            if (snapshot.hasData) {
              switch (snapshot.data) {

                ///
                ///
                /// Form
                case RegisterStatus.form:
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Logo(),
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
                                NewDefaultTextField(
                                  labelText: 'E-mail',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) =>
                                      EmailValidator.validate(value)
                                          ? null
                                          : 'Informe um email válido.',
                                ),
                                NewDefaultTextField(
                                  labelText: 'Senha',
                                  controller: _passwordController,
                                  isPassword: true,
                                  validator: (String value) => value.isEmpty
                                      ? 'Informe sua senha.'
                                      : null,
                                ),
                                NewDefaultTextField(
                                  labelText: 'Nome',
                                  controller: _nameController,
                                  validator: (String value) => value.isEmpty
                                      ? 'Informe seu nome.'
                                      : null,
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'Cadastrar',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.green,
                            onPressed: () => _registerUser(context),
                          ),
                          FlatButton(
                            child: Text(
                              'Cancelar',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.redAccent,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  );

                ///
                ///
                /// Register
                case RegisterStatus.register:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Criando usuário...'),
                        ),
                      ],
                    ),
                  );

                ///
                ///
                /// Go
                case RegisterStatus.go:
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
              child: Text('Erro'),
            );
          },
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _goAhead(BuildContext context) async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<MainScreen>(
          builder: (BuildContext context) => MainScreen(),
        ),
        (dynamic route) => false);
  }

  ///
  ///
  ///
  void _registerUser(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _controller.add(RegisterStatus.register);
      try {
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        User user = auth.currentUser;

        await user.updateProfile(displayName: _nameController.text);

        AppUser appUser = AppUser(
          email: user.email,
          name: _nameController.text,
        );

        await _firestore.collection('users').doc(user.uid).set(appUser.toMap());

        _controller.add(RegisterStatus.go);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          await DisplayAlert.show(
            context: context,
            message: 'Sua senha deve possuir pelo '
                'menos 6 caracteres, por favor, tente novamente.',
          );
        } else if (e.code == 'email-already-in-use') {
          await DisplayAlert.show(
            context: context,
            message: 'O e-mail informado já esta em uso, '
                'por favor utilize outro.',
          );
        }
        _controller.add(RegisterStatus.form);
      } catch (e) {
        await DisplayAlert.show(
          context: context,
          message: 'Erro ao realizar cadastro, '
              'por favor, tente novamente mais tarde',
        );
        _controller.add(RegisterStatus.form);
      }
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
    _nameController.dispose();
    super.dispose();
  }
}
