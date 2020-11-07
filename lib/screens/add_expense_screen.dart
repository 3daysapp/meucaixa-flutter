import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';
import 'package:meu_caixa_flutter/utils/config.dart';

///
///
///
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

///
///
///
class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Expense expense = Expense();
  String selectedProvider = '';
  final MoneyMaskedTextController valueController = MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: ',',
  );

  ///
  ///
  ///
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
        children: <Widget>[
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
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .doc(_auth.currentUser.uid)
                .collection('providers')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }

              final List<QueryDocumentSnapshot> providerSnapshot =
                  snapshot.data.docs;
              List<DropdownMenuItem<String>> supplierList =
                  <DropdownMenuItem<String>>[];

              for (QueryDocumentSnapshot supplierSnapshot
                  in providerSnapshot.reversed) {
                Map<String, dynamic> supplierData = supplierSnapshot.data();
                Supplier supplier =
                    Supplier.fromMap(supplierSnapshot.id, supplierData);
                final DropdownMenuItem<String> dropdown =
                    DropdownMenuItem<String>(
                  child: Text(supplier.name),
                  value: supplier.name,
                );
                supplierList.add(dropdown);
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  isExpanded: true,
                  iconSize: 0,
                  value:
                      expense.supplier != null ? expense.supplier.name : null,
                  items: supplierList,
                  onChanged: (String value) {
                    setState(() {
                      expense.supplier = Supplier();
                      expense.supplier.name = value;
                    });
                  },
                ),
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
                color: Config.radicalRedColor,
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
