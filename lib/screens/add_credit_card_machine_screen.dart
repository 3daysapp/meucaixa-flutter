import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

///
///
///
class AddCreditCardMachineScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CreditCardMachine creditCardMachine = CreditCardMachine();

  ///
  ///
  ///
  void addCreditCardMachine(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      User user = UserUtils.getCurrentUser();
      try {
        await _firestore.collection('creditCardMachines').add({
          'userId': user.uid,
          'name': creditCardMachine.name,
        });

        showAlertDialog(
          context: context,
          title: 'Sucesso',
          message: 'Máquina de cartão adicionada com sucesso',
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        );
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao adicionar máquina.\n'
                'Por favor, tente novamente mais tarde!'),
          ),
        );
      }
    }
  }

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
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Adicionar nova maquina de cartão',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          DefaultTextField(
            hintText: 'Nome da Maquina',
            callback: (value) => creditCardMachine.name = value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor, informe o nome da máquina';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SizedBox(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  addCreditCardMachine(context);
                },
                color: Colors.blueAccent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('Adicionar Máquina de Cartão'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
