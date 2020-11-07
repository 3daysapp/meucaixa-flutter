import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/app_version.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/drawer_menu.dart';
import 'package:meu_caixa_flutter/components/menu_item.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_open_screen.dart';
import 'package:meu_caixa_flutter/screens/supplier_screen.dart';

///
///
///
class MainScreen extends StatefulWidget {
  static String screenId = 'mainScreen';

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

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerMenu(),
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
                        label: 'Fechar Caixa',
                        color: Colors.green,
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<CashRegistryOpenScreen>(
                              builder: (BuildContext context) =>
                                  CashRegistryOpenScreen(),
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.analytics_outlined,
                        label: 'Histórico',
                        color: Colors.redAccent,
                        action: () {
                          DisplayAlert.show(
                            context: context,
                            message: 'Módulo em desenvolvimento, '
                                'por favor, aguarde!',
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.add_business_outlined,
                        label: 'Fornecedores',
                        color: Colors.teal,
                        action: () => Navigator.of(context).push(
                          MaterialPageRoute<SupplierScreen>(
                            builder: (_) => SupplierScreen(),
                          ),
                        ),
                      ),
                      MenuItem(
                        icon: Icons.attach_money_sharp,
                        label: 'Maquinas de cartão de crédito',
                        color: Colors.blueAccent,
                        action: () {
                          DisplayAlert.show(
                            context: context,
                            message: 'Módulo em desenvolvimento, '
                                'por favor, aguarde!',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// Version
              AppVersion(),
            ],
          ),
        ),
      ),
    );
  }
}
