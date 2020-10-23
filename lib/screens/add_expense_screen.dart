import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/models/provider.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  var descriptionController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  Expense expense = Expense();
  String selectedProvider = '';
  final valueController =
      MoneyMaskedTextController(thousandSeparator: '.', decimalSeparator: ',');
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text('Escolha o fornecedor'),
          ),
          StreamBuilder(
            stream: _firestore
                .collection('providers')
                .where("userId", isEqualTo: UserUtils.getCurrentUser().uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final providerSnapshot = snapshot.data.docs;
              List<DropdownMenuItem<String>> providerList = [];
              for (var provide in providerSnapshot.reversed) {
                var p = provide.data();
                print(p);
                if (p['name'] != null) {
                  final dropdown = DropdownMenuItem<String>(
                    child: Text(p['name']),
                    value: p['name'],
                  );
                  providerList.add(dropdown);
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                    isExpanded: true,
                    iconSize: 0,
                    value:
                        expense.provider != null ? expense.provider.name : null,
                    items: providerList,
                    onChanged: (value) {
                      setState(() {
                        expense.provider = Provider();
                        expense.provider.name = value;
                      });
                    }),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SizedBox(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  expense.value = valueController.numberValue;
                  expense.description = descriptionController.text;
                  Navigator.pop(context, expense);
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
