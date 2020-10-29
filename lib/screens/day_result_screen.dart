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
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

///
///
///
class DayResultScreen extends StatefulWidget {
  static String screenId = 'DayResultScreen';
  final CashRegistry cashRegistry;

  ///
  ///
  ///
  const DayResultScreen({@required this.cashRegistry, Key key})
      : super(key: key);

  ///
  ///
  ///
  @override
  _DayResultScreenState createState() => _DayResultScreenState();
}

///
///
///
class _DayResultScreenState extends State<DayResultScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///
  ///
  ///
  List<Widget> getExpenseContainerList() {
    List<Widget> expList = <Widget>[];

    for (Expense exp in widget.cashRegistry.expenseList) {
      final MoneyMaskedTextController mask = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
      );

      mask.text = exp.value.toString();

      final ExpenseResultCard expContainer = ExpenseResultCard(
        exp: exp,
        mask: mask,
      );

      expList.add(expContainer);
    }

    return expList;
  }

  ///
  ///
  ///
  Future<void> saveCashRegistry(BuildContext context) async {
    try {
      DocumentReference reference = await _firestore
          .collection('cashRegistryHistory')
          .add(<String, dynamic>{
        'userId': UserUtils.getCurrentUser()
            .uid, // FIXME - Estrutura do firestore :-(
        'date': widget.cashRegistry.date,
        'openValue': widget.cashRegistry.openValue,
        'totalCreditCardMachine': widget.cashRegistry.totalCreditCardMachine,
        'totalExpenses': widget.cashRegistry.totalExpenses,
        'totalMoney': widget.cashRegistry.totalMoney,
        'total': widget.cashRegistry.total,
      });

      await _saveExpenses(reference);

      await _saveCreditCardMachines(reference);

      await DisplayAlert.show(
        context: context,
        title: 'Sucesso',
        message: 'Caixa salvo com sucesso.',
      );

      await Navigator.of(context).pushNamedAndRemoveUntil(
        MainScreen.screenId,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      await DisplayAlert.show(
        context: context,
        title: 'Erro',
        message: 'Falha ao salvar o caixa.\n'
            'Por favor, tente novamente mais tarde',
      );
    }
  }

  ///
  ///
  ///
  void _saveExpenses(DocumentReference reference) {
    for (Expense expense in widget.cashRegistry.expenseList) {
      _firestore
          .collection('cashRegistryHistory')
          .doc(reference.id)
          .collection('expenses')
          .add(<String, dynamic>{
        'description': expense.description,
        'value': expense.value,
        'cashRegistryId': reference.id,
        'providerName': expense.provider.name,
        'providerId': expense.provider.id,
      });
    }
  }

  ///
  ///
  ///
  void _saveCreditCardMachines(DocumentReference reference) async {
    for (CreditCardMachine creditCardMachine
        in widget.cashRegistry.creditCardMachineList) {
      await _firestore
          .collection('cashRegistryHistory')
          .doc(reference.id)
          .collection('creditCardMachine')
          .add(<String, dynamic>{
        'name': creditCardMachine.name,
        'value': creditCardMachine.controller.text,
        'cashRegistryId': reference.id,
      });
    }
  }

  ///
  ///
  /// TODO - Dart style
  List<Widget> getCreditCardMachineContainerList() =>
      widget.cashRegistry.creditCardMachineList
          .map((CreditCardMachine cardMachine) =>
              CreditCardMachineCard(cardMachine: cardMachine))
          .toList();

  // List<Widget> getCreditCardMachineContainerList() {
  //   List<Widget> creditCardMachineContainerList = <Widget>[];
  //
  //   for (CreditCardMachine cardMachine
  //       in widget.cashRegistry.creditCardMachineList) {
  //     final CreditCardMachineCard expContainer =
  //         CreditCardMachineCard(cardMachine: cardMachine);
  //     creditCardMachineContainerList.add(expContainer);
  //   }
  //
  //   return creditCardMachineContainerList;
  // }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    widget.cashRegistry.calculate();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fechamento'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CardTitle(
                  title: 'Despesas',
                  color: Colors.redAccent,
                ),
                Column(
                  children: getExpenseContainerList(),
                ),
                CardTitle(
                  title: 'Máquinas de cartão',
                  color: Colors.blue,
                ),
                Column(
                  children: getCreditCardMachineContainerList(),
                ),
                CardTitle(
                  title: 'Dinheiro',
                  color: Colors.green,
                ),
                NormalCard(
                  title: 'Total',
                  trailing:
                      'R\$ ${widget.cashRegistry.totalMoney.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
                NormalCard(
                  title: 'Caixa aberto com',
                  trailing:
                      'R\$ ${widget.cashRegistry.openValue.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
                CardTitle(
                  title: 'Resultado do dia',
                  color: widget.cashRegistry.total > 0
                      ? Colors.green
                      : Colors.redAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Máquinas de cartão:  '
                        'R\$ ${widget.cashRegistry.totalCreditCardMachine.toStringAsFixed(2)}',
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        'Dinheiro:  '
                        'R\$ ${widget.cashRegistry.totalMoney.toStringAsFixed(2)}',
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        'Abertura do caixa:  '
                        'R\$ ${widget.cashRegistry.openValue.toStringAsFixed(2)}',
                        style: kDefaultResultTextStyle,
                      ),
                      Text(
                        'Despesas:  '
                        'R\$ ${widget.cashRegistry.totalExpenses.toStringAsFixed(2)}',
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
                        'Lucro:  '
                        'R\$ ${widget.cashRegistry.total.toStringAsFixed(2)}',
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
                    child: Text('Fechar o caixa'),
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

///
///
///
class CardTitle extends StatelessWidget {
  final Color color;
  final String title;

  ///
  ///
  ///
  const CardTitle({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  ///
  ///
  ///
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

///
///
///
class CreditCardMachineCard extends StatelessWidget {
  final CreditCardMachine cardMachine;

  ///
  ///
  ///
  const CreditCardMachineCard({
    Key key,
    @required this.cardMachine,
  }) : super(key: key);

  ///
  ///
  ///
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
              children: <Widget>[
                Text(cardMachine.name.toUpperCase()),
                Text('R\$ ${cardMachine.controller.value.text}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///
///
///
class ExpenseResultCard extends StatelessWidget {
  final Expense exp;
  final MoneyMaskedTextController mask;

  ///
  ///
  ///
  const ExpenseResultCard({
    Key key,
    @required this.exp,
    @required this.mask,
  }) : super(key: key);

  ///
  ///
  ///
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
              children: <Widget>[
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
