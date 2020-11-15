import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/utils/config.dart';

///
///
///
class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final Function callback;
  final bool finalResult;

  final Config config = Config();

  ///
  ///
  ///
  ExpenseCard({
    @required this.expense,
    @required this.callback,
    this.finalResult = false,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${expense.description.toUpperCase()} '
                    '${expense.supplier != null ? '- ${expense.supplier.name}' : ''}',
                  ),
                  // TODO - User money format
                  Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                      .format(expense.value)),
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
