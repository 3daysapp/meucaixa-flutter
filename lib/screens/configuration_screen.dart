import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationScreen extends StatefulWidget {
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  /// TODO implementar a alteracao da imagem do usuario

  bool automaticLogin = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Row(children: [
              Checkbox(
                value: automaticLogin,
                onChanged: (bool value) {
                  _savePreferences(value);
                  setState(() {
                    automaticLogin = value;
                  });
                },
              ),
              Text('Fazer login automaticamente')
            ]),
          ],
        ),
      ),
    );
  }

  void _savePreferences(bool automaticLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('automaticLogin', automaticLogin);
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('automaticLogin')) {
      bool autoLogin = await prefs.getBool('automaticLogin');
      setState(() {
        automaticLogin = autoLogin;
      });
    }
  }
}
