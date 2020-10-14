import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';

class AddExpenseScreen extends StatelessWidget {
  static String screenId = 'add_expense_screen';
  @override
  Widget build(BuildContext context) {
    var valueController = MoneyMaskedTextController(
        thousandSeparator: '.', decimalSeparator: ',');
    return Container(
        child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Adicionar nova despesa',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kRadicalRedColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          DefaultTextField(
            hintText: 'Descrição',
            controller: valueController,
          )
        ],
      ),
    ));
  }
}
