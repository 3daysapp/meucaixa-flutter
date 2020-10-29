import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/menu_item.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';
import 'package:meu_caixa_flutter/screens/login_screen.dart';
import 'package:meu_caixa_flutter/screens/supplier_screen.dart';
import 'package:package_info/package_info.dart';

///
///
///
class MainScreen extends StatefulWidget {
  static String screenId = 'mainScreen';
  const MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final User user = FirebaseAuth.instance.currentUser;

  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  ///
  ///
  ///
  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Aviso'),
        content: Text('Deseja realmente sair do app?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Não'),
          ),
          SizedBox(height: 16),
          FlatButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.screenId, (route) => false),
            child: Text('Sim'),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    // int numberOfTimesPressedBackButton = 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meu caixa'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MenuItem(
                        icon: Icons.assignment_outlined,
                        label: 'Fechar caixa',
                        height: 80,
                        color: Colors.green,
                        action: () {
                          Navigator.of(context)
                              .pushNamed(ExpenseScreen.screenId);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MenuItem(
                        icon: Icons.analytics_outlined,
                        label: 'Histórico',
                        height: 80,
                        color: Colors.blueAccent,
                        action: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MenuItem(
                        icon: Icons.add_business_outlined,
                        label: 'Fornecedores',
                        height: 80,
                        color: Colors.teal,
                        action: () {
                          Navigator.of(context)
                              .pushNamed(ProviderScreen.screenId);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MenuItem(
                        icon: Icons.exit_to_app_outlined,
                        label: 'Sair',
                        height: 80,
                        color: Colors.red,
                        action: () {
                          logout(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('${_packageInfo.version}.${_packageInfo.buildNumber}'),
                    Text(releaseDate)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
