import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/menu_item.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_open_screen.dart';
import 'package:meu_caixa_flutter/screens/login_screen.dart';
import 'package:meu_caixa_flutter/screens/supplier_screen.dart';
import 'package:package_info/package_info.dart';

///
///
///
class MainScreen extends StatefulWidget {
  static String screenId = 'mainScreen';

  ///
  ///
  ///
  const MainScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _MainScreenState createState() => _MainScreenState();
}

///
///
///
class _MainScreenState extends State<MainScreen> {
  final User user = FirebaseAuth.instance.currentUser;

  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  ///
  ///
  ///
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meu Caixa'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// Buttons
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MenuItem(
                        icon: Icons.assignment_outlined,
                        label: 'Fechar caixa',
                        color: Colors.green,
                        action: () => Navigator.of(context)
                            .pushNamed(CashRegistryOpenScreen.screenId),
                      ),
                      MenuItem(
                        icon: Icons.analytics_outlined,
                        label: 'Histórico',
                        color: Colors.blueAccent,
                        action: () {},
                      ),
                      MenuItem(
                        icon: Icons.add_business_outlined,
                        label: 'Fornecedores',
                        color: Colors.teal,
                        action: () => Navigator.of(context)
                            .pushNamed(ProviderScreen.screenId),
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app_outlined,
                        label: 'Sair',
                        color: Colors.red,
                        action: _logout,
                      ),
                    ],
                  ),
                ),
              ),

              /// Version
              /// TODO - Este container poderia ser um Widget separado?
              /// Desacoplamento?? Responsabilidade. StatefulWidget...
              Container(
                child: Column(
                  children: <Widget>[
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

  ///
  ///
  ///
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
                LoginScreen.screenId, (Route<dynamic> route) => false),
            child: Text('Sim'),
          ),
        ],
      ),
    );
  }
}
