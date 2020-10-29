import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';

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
        body: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultTextField(
                hintText: "Com quantos reais você abriu o caixa hoje?",
                controller: _controller,
              ),
              SizedBox(
                height: 75,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: RaisedButton(
                    onPressed: () {},
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
    );
  }
}
