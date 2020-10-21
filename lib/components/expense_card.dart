import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final Function callback;
  final bool finalResult;
  final controller =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  ExpenseCard(
      {@required this.expense,
      @required this.callback,
      this.finalResult = false});

  @override
  Widget build(BuildContext context) {
    controller.updateValue(expense.value);
    print(controller.value.text);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense.description.toUpperCase()),
                  Text('R\$ ${controller.value.text}'),
                ],
              ),
            ),
            IconButton(
              onPressed: callback,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
