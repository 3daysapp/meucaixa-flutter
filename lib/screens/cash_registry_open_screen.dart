import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';

class CashRegistryOpenScreen extends StatefulWidget {
  const CashRegistryOpenScreen({Key key}) : super(key: key);
  static String screenId = 'cashRegistryOpenScreen';

  @override
  _CashRegistryOpenScreenState createState() => _CashRegistryOpenScreenState();
}

class _CashRegistryOpenScreenState extends State<CashRegistryOpenScreen> {
  final MoneyMaskedTextController _controller =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final CashRegistry cashRegistry = CashRegistry();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Abertura do caixa'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return await DisplayAlert.yesNo(
                context: context,
                message: 'Deseja mesmo cancelar o lançamento do caixa?');
          },
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DefaultTextField(
                  hintText: 'Valor de abertura do caixa',
                  controller: _controller,
                ),
                SizedBox(
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        cashRegistry.openValue = _controller.numberValue;
                        Navigator.of(context).push(
                          MaterialPageRoute<ExpenseScreen>(
                              builder: (BuildContext context) => ExpenseScreen(
                                    cashRegistry: cashRegistry,
                                  )),
                        );
                      },
                      child: Text(
                        'Avançar',
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
