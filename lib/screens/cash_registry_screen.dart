import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/cash_container.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/day_result_screen.dart';

///
///
///
class CashRegistryScreen extends StatefulWidget {
  static String screenId = 'caixa_screen';
  final CashRegistry cashRegistry;

  ///
  ///
  ///
  const CashRegistryScreen({
    Key key,
    @required this.cashRegistry,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _CashRegistryScreenState createState() => _CashRegistryScreenState();
}

///
///
///
class _CashRegistryScreenState extends State<CashRegistryScreen> {
  MoneyMaskedTextController cashRegistryOpenValueController;

  ///
  ///
  ///
  void calculaTotal() {
    widget.cashRegistry.getTotalMoney;
  }

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    cashRegistryOpenValueController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
    );
    setState(() {
      widget.cashRegistry.getTotalMoney;
    });
  }

  ///
  ///
  ///
  @override
  void dispose() {
    super.dispose();
    cashRegistryOpenValueController.dispose();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                CashContainer(
                  label: 'Notas de 2R\$',
                  initialValue: widget.cashRegistry.note2,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note2 = value;
                      calculaTotal();
                    });
                  },
                ),
                CashContainer(
                  label: 'Notas de 5R\$',
                  initialValue: widget.cashRegistry.note5,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note5 = value;
                      calculaTotal();
                    });
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                CashContainer(
                  label: 'Notas de 10R\$',
                  initialValue: widget.cashRegistry.note10,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note10 = value;
                      calculaTotal();
                    });
                  },
                ),
                CashContainer(
                  label: 'Notas de 20R\$',
                  initialValue: widget.cashRegistry.note20,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note20 = value;
                      calculaTotal();
                    });
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                CashContainer(
                  label: 'Notas de 50R\$',
                  initialValue: widget.cashRegistry.note50,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note50 = value;
                      calculaTotal();
                    });
                  },
                ),
                CashContainer(
                  label: 'Notas de 100R\$',
                  initialValue: widget.cashRegistry.note100,
                  onChanged: (int value) {
                    setState(() {
                      widget.cashRegistry.note100 = value;
                      calculaTotal();
                    });
                  },
                ),
              ],
            ),

            ///
            ///
            /// TODO - Aqui ser o Stream Builder.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: ${widget.cashRegistry.getTotalMoney.toStringAsFixed(2)} R\$',
                style: kDefaultTotalTextStyle, // TODO - Legibilidade.
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<DayResultScreen>(
                      builder: (BuildContext context) =>
                          DayResultScreen(cashRegistry: widget.cashRegistry),
                    ),
                  );
                },
                child: Text(
                  'Salvar Caixa',
                  style: TextStyle(fontSize: 18),
                ),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
///
///
class FloatActionButtonAddDespesas extends StatelessWidget {
  final Function callback;

  ///
  ///
  ///
  const FloatActionButtonAddDespesas({
    Key key,
    @required this.callback,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Expense expense = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddExpenseScreen(),
          ),
        );
        callback(expense);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 45,
      ),
      backgroundColor: kRadicalRedColor,
      tooltip: 'Adiciona uma nova despesa ao caixa',
    );
  }
}
