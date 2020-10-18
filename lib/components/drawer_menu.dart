import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/menu_item.dart';
import 'package:meu_caixa_flutter/screens/caixa_screen.dart';

class DrawerMenu extends StatelessWidget {
  String _userName = FirebaseAuth.instance.currentUser.displayName;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/meucaixa-logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MenuItem(
                  label: "Fechar caixa",
                  action: () {
                    Navigator.of(context).pushNamed(CaixaScreen.screenId);
                  },
                  icon: Icons.monetization_on,
                ),
                MenuItem(
                  label: "Histórico",
                  action: () {},
                  icon: Icons.analytics_outlined,
                ),
                MenuItem(
                  label: "Sair",
                  action: () {
                    showAlertDialog(
                      context: context,
                      title: "Confirmar saida",
                      message: "Tem certeza que deseja sair?",
                      actions: <Widget>[
                        Row(
                          children: [
                            FlatButton(onPressed: () {}, child: Text('Não')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim')),
                          ],
                        )
                      ],
                    );
                  },
                  icon: Icons.exit_to_app_outlined,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              child: Column(
                children: [
                  Text('0.1'),
                  Text('18/10/2020'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
