import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/normal_card.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  ///
  ///
  List<Widget> getExpenseContainerList() {
    List<Widget> expList = <Widget>[];

    for (Expense exp in widget.cashRegistry.expenseList) {
      final ExpenseResultCard expContainer = ExpenseResultCard(exp: exp);
      expList.add(expContainer);
    }

    return expList;
  }

  ///
  ///
  ///
  Future<void> saveCashRegistry(BuildContext context) async {
    try {
      print('Iniciando o lançamento');
      print(widget.cashRegistry.toMap());
      DocumentReference reference = await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .collection('cashRegistryHistory')
          .add(widget.cashRegistry.toMap());

      print('Lançou o caixa');
      await _saveExpenses(reference);
      print('Lançou as despesas');
      await _saveCreditCardMachines(reference);
      print('Lançou as maquinas');
      await DisplayAlert.show(
        context: context,
        title: 'Sucesso',
        message: 'Caixa salvo com sucesso.',
      );

      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<MainScreen>(
              builder: (BuildContext context) => MainScreen()),
          (dynamic route) => false);
    } catch (e) {
      print(e);
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
  void _saveExpenses(DocumentReference reference) async {
    for (Expense expense in widget.cashRegistry.expenseList) {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .collection('cashRegistryHistory')
          .doc(reference.id)
          .collection('expenses')
          .add(expense.toMap());
    }
  }

  ///
  ///
  ///
  void _saveCreditCardMachines(DocumentReference reference) async {
    for (CreditCardMachine creditCardMachine
        in widget.cashRegistry.creditCardMachineList) {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .collection('cashRegistryHistory')
          .doc(reference.id)
          .collection('creditCardMachine')
          .add(creditCardMachine.toMap());
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
                      'R\$ ${widget.cashRegistry.getTotalMoney.toStringAsFixed(2)}',
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
                        'Máquinas de cartão: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.cashRegistry.getTotalCreditCardMachine)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Dinheiro: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.cashRegistry.getTotalMoney)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Abertura do caixa: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.cashRegistry.openValue)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Despesas: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.cashRegistry.getTotalExpenses)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 1,
                        width: 80,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Lucro:  ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.cashRegistry.total)}',
                        style: TextStyle(fontSize: 18),
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
                Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                    .format(cardMachine.value)),
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

  ///
  ///
  ///
  const ExpenseResultCard({Key key, @required this.exp}) : super(key: key);

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
                exp.supplier != null ? Text(exp.supplier.name) : Text(''),
                Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                    .format(exp.value))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
