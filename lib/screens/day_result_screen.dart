import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:intl/intl.dart';

class DayResultScreen extends StatelessWidget {
  static String screenId = "DayResultScreen";
  final CashRegistry cashRegistry;
  DayResultScreen({@required this.cashRegistry});

  List<Widget> getExpenseContainerList() {
    List<Widget> expList = [];
    for (Expense exp in cashRegistry.expenseList) {
      final mask = MoneyMaskedTextController(
          decimalSeparator: ',', thousandSeparator: '.');
      mask.text = exp.value.toString();
      final expContainer = ExpenseResultCard(exp: exp, mask: mask);
      expList.add(expContainer);
    }
    return expList;
  }

  List<Widget> getCreditCardMachineContainerList() {
    List<Widget> creditCardMachineContainerList = [];
    for (CreditCardMachine cardMachine in cashRegistry.creditCardMachineList) {
      final expContainer = CreditCardMachineCard(cardMachine: cardMachine);
      creditCardMachineContainerList.add(expContainer);
    }
    return creditCardMachineContainerList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fechamento'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: "Despesas",
                  color: Colors.redAccent,
                ),
                Column(
                  children: getExpenseContainerList(),
                ),
                CardTitle(
                  title: "Máquinas de cartão",
                  color: Colors.blue,
                ),
                Column(
                  children: getCreditCardMachineContainerList(),
                ),
                CardTitle(
                  title: "Dinheiro",
                  color: Colors.green,
                ),
                NormalCard(
                  title: "Total",
                  trailing: "R\$ ${cashRegistry.totalMoney.toStringAsFixed(2)}",
                ),
                CardTitle(
                    title: "Resultado do dia",
                    color: cashRegistry.total > 0
                        ? Colors.green
                        : Colors.redAccent),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        "Máquinas de cartão: ${cashRegistry.totalCreditCardMachine.toStringAsFixed(2)} R\$"),
                    Text(
                        "Dinheiro: ${cashRegistry.totalMoney.toStringAsFixed(2)} R\$"),
                    Text(
                        "Despesas:  ${cashRegistry.totalExpenses.toStringAsFixed(2)} R\$"),
                    SizedBox(
                      height: 1,
                      width: 80,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Text("Lucro: ${cashRegistry.total.toStringAsFixed(2)} R\$"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NormalCard extends StatelessWidget {
  final String title;
  final String trailing;

  NormalCard({@required this.title, @required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(trailing),
            ],
          ),
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final Color color;
  final String title;
  CardTitle({@required this.title, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class CreditCardMachineCard extends StatelessWidget {
  const CreditCardMachineCard({
    Key key,
    @required this.cardMachine,
  }) : super(key: key);

  final CreditCardMachine cardMachine;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardMachine.name.toUpperCase()),
              Text('R\$ ${cardMachine.controller.value.text}')
            ],
          ),
        ),
      ),
    ));
  }
}

class ExpenseResultCard extends StatelessWidget {
  const ExpenseResultCard({
    Key key,
    @required this.exp,
    @required this.mask,
  }) : super(key: key);

  final Expense exp;
  final MoneyMaskedTextController mask;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(exp.description.toUpperCase()),
                Text('R\$ ${mask.value.text}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
