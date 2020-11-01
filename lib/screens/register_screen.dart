import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/new_default_textfield.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // bool showSpinner = false;

  ///
  ///
  ///
  void registerUser() async {
    if (_formKey.currentState.validate()) {
      // toggleSpinner();
      try {
        await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        User user = auth.currentUser;
        await user.updateProfile(displayName: _nameController.text);
        // toggleSpinner();

        await Navigator.pushNamed(context, MainScreen.screenId);
      } on FirebaseAuthException catch (e) {
        // toggleSpinner();
        if (e.code == 'weak-password') {
        } else if (e.code == 'email-already-in-use') {}
      } catch (e) {
        // toggleSpinner();
        print(e);
      }
    }
  }

  ///
  ///
  ///
  // void toggleSpinner() {
  //   /// Caso clássico de utilização de stream.
  //   setState(() {
  //     showSpinner = !showSpinner;
  //   });
  // }

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
              padding: EdgeInsets.all(16),
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
                          validator: (String value) =>
                              value.isEmpty ? 'Informe sua senha' : null,
                        ),
                        NewDefaultTextField(
                          labelText: 'Nome',
                          controller: _nameController,
                          validator: (String value) =>
                              value.isEmpty ? 'Informe seu nome' : null,
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
                      onPressed: () {
                        registerUser();
                      }),
                  FlatButton(
                      child: Text(
                        'Cancelar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
