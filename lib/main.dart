import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/caixascreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: CaixaScreen(),
      ),
    );
  }
}
