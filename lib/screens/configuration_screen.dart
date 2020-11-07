import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
class ConfigurationScreen extends StatefulWidget {
  ///
  ///
  ///
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

///
///
///
class _ConfigurationScreenState extends State<ConfigurationScreen> {
  ///
  /// TODO implementar a alteracao da imagem do usuario
  ///
  bool automaticLogin = false;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  ///
  ///
  ///
  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('automaticLogin')) {
      bool autoLogin = await prefs.getBool('automaticLogin');
      setState(() => automaticLogin = autoLogin);
    }
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: automaticLogin,
                  onChanged: (bool value) {
                    setState(() => automaticLogin = value);
                    _savePreferences();
                  },
                ),
                Text('Fazer login automaticamente')
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('automaticLogin', automaticLogin);
  }
}
