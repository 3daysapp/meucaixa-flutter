import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_screen.dart';

class CreditCardScreen extends StatefulWidget {
  static String screenId = "CreditCardScreen";

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  var scieloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var steloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  CashRegistry _cashRegistry = CashRegistry();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cartões de crédito"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                DefaultTextField(
                  horizontalPadding: 10,
                  hintText: 'Cartão Scielo',
                  controller: scieloController,
                  callback: (value) {
                    setState(
                      () {
                        _cashRegistry.scielo = value;
                      },
                    );
                  },
                ),
                DefaultTextField(
                  horizontalPadding: 10,
                  hintText: 'Cartão Stelo',
                  controller: steloController,
                  callback: (value) {
                    setState(
                      () {
                        _cashRegistry.stelo = value;
                      },
                    );
                  },
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CashRegistryScreen.screenId);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Avançar"),
                      Icon(Icons.arrow_right_outlined),
                    ],
                  ),
                  color: Colors.blueAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
