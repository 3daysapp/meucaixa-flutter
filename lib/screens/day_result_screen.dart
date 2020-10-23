import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/normal_card.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

class DayResultScreen extends StatelessWidget {
  static String screenId = "DayResultScreen";
  final CashRegistry cashRegistry;
  final _firestore = FirebaseFirestore.instance;
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

  Future<void> saveCashRegistry(BuildContext context) async {
    try {
      DocumentReference reference =
          await _firestore.collection("cashRegistryHistory").add({
        "userId": UserUtils.getCurrentUser().uid,
        "date": cashRegistry.date,
        "openValue": cashRegistry.openValue,
        "totalCreditCardMachine": cashRegistry.totalCreditCardMachine,
        "totalExpenses": cashRegistry.totalExpenses,
        "totalMoney": cashRegistry.totalMoney,
        "total": cashRegistry.total
      });
      await _saveExpenses(reference);
      await _saveCreditCardMachines(reference);
      showAlertDialog(
        context: context,
        message: "Caixa salvo com sucesso.",
        title: "Sucesso",
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainScreen.screenId, (route) => false);
              },
              child: Text("OK")),
        ],
      );
    } catch (e) {
      showAlertDialog(
        context: context,
        message:
            "Falha ao salvar o caixa, por favor, tente novamente mais tarde",
        title: "Erro",
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK")),
        ],
      );
    }
  }

  Future<void> _saveExpenses(DocumentReference reference) {
    for (Expense expense in cashRegistry.expenseList) {
      _firestore
          .collection("cashRegistryHistory")
          .doc(reference.id)
          .collection("expenses")
          .add({
        "description": expense.description,
        "value": expense.value,
        "cashRegistryId": reference.id,
        "providerName": expense.provider.name,
        "providerId": expense.provider.id
      });
    }
  }

  Future<void> _saveCreditCardMachines(DocumentReference reference) async {
    for (CreditCardMachine creditCardMachine
        in cashRegistry.creditCardMachineList) {
      _firestore
          .collection("cashRegistryHistory")
          .doc(reference.id)
          .collection("creditCardMachine")
          .add({
        "name": creditCardMachine.name,
        "value": creditCardMachine.controller.text,
        "cashRegistryId": reference.id
      });
    }
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
    cashRegistry.calculate();
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
                  color: Colors.green,
                ),
                NormalCard(
                  title: "Caixa aberto com",
                  trailing: "R\$ ${cashRegistry.openValue.toStringAsFixed(2)}",
                  color: Colors.green,
                ),
                CardTitle(
                    title: "Resultado do dia",
                    color: cashRegistry.total > 0
                        ? Colors.green
                        : Colors.redAccent),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Máquinas de cartão:  R\$ ${cashRegistry.totalCreditCardMachine.toStringAsFixed(2)}",
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        "Dinheiro:  R\$ ${cashRegistry.totalMoney.toStringAsFixed(2)}",
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        "Abertura do caixa:  R\$ ${cashRegistry.openValue.toStringAsFixed(2)}",
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        "Despesas:  R\$ ${cashRegistry.totalExpenses.toStringAsFixed(2)}",
                        style: kDefaultResultTextStyle,
                      ),
                      SizedBox(
                        height: 1,
                        width: 80,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Lucro:  R\$ ${cashRegistry.total.toStringAsFixed(2)}",
                        style: kDefaultResultTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      await saveCashRegistry(context);
                    },
                    color: Colors.green,
                    child: Text("Fechar o caixa"),
                  ),
                ),
              ],
            ),
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
                exp.provider != null ? Text(exp.provider.name) : Text(''),
                Text('R\$ ${mask.value.text}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
