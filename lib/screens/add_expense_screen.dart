import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/data/expense_data.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatelessWidget {
  static String screenId = 'add_expense_screen';
  var descriptionController = TextEditingController();
  void addExpense(BuildContext context, Expense expense) {
    Provider.of<ExpenseData>(context, listen: false).addExpenseToList(expense);
  }

  @override
  Widget build(BuildContext context) {
    var valueController = MoneyMaskedTextController(
        thousandSeparator: '.', decimalSeparator: ',');
    return Container(
      height: 260,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Adicionar nova despesa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          DefaultTextField(
            hintText: 'Descrição',
            controller: descriptionController,
          ),
          DefaultTextField(
            hintText: 'Valor da despesa',
            controller: valueController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SizedBox(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Expense expense = Expense();
                  expense.value = valueController.numberValue;
                  expense.description = descriptionController.text;
                  addExpense(context, expense);
                },
                color: kRadicalRedColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('Adicionar despesa'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}