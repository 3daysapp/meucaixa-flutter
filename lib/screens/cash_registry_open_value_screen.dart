import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';

class CashRegistryOpenScreen extends StatefulWidget {
  const CashRegistryOpenScreen({Key key}) : super(key: key);
  static String screenId = 'cashRegistryOpenScreen';

  @override
  _CashRegistryOpenScreenState createState() => _CashRegistryOpenScreenState();
}

class _CashRegistryOpenScreenState extends State<CashRegistryOpenScreen> {
  final MoneyMaskedTextController _controller =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Abertura do caixa'),
        ),
        body: WillPopScope(
          onWillPop: () async => showDialog(
            context: context,
            // TODO - Usar DisplayAlert.yesNo
            builder: (BuildContext context) => AlertDialog(
              title: Text('Aviso'),
              content: Text(
                'Tem certeza que deseja voltar?\n'
                'Ao voltar, o lançamento do caixa sera cancelado!',
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text('NÃO'),
                  color: Colors.green,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                RaisedButton(
                    child: Text('SIM'),
                    color: Colors.redAccent,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          MainScreen.screenId, (dynamic route) => true);
                    }),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DefaultTextField(
                  hintText: 'Com quantos reais você abriu o caixa hoje?',
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
                        Navigator.of(context).pushNamed(ExpenseScreen.screenId);
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
