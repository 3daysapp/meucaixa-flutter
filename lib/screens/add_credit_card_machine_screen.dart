import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/new_default_textfield.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';

///
/// TODO - Essa classe pode ser refatorada para ser inclusão e alteração.
///
class AddCreditCardMachineScreen extends StatefulWidget {
  final CreditCardMachine creditCardMachine;

  ///
  ///
  ///
  const AddCreditCardMachineScreen({
    Key key,
    this.creditCardMachine,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _AddCreditCardMachineScreenState createState() =>
      _AddCreditCardMachineScreenState();
}

///
///
///
class _AddCreditCardMachineScreenState
    extends State<AddCreditCardMachineScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreditCardMachine _creditCardMachine = CreditCardMachine();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _creditCardMachine = widget.creditCardMachine ?? CreditCardMachine();
  }

  ///
  ///  TODO - Padronizar a interface.
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
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Adicionar nova máquina de cartão',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          NewDefaultTextField(
            labelText: 'Nome da Máquina',
            initialValue: _creditCardMachine.name,
            validator: (String value) =>
                value.isEmpty ? 'Por favor, informe o nome da máquina' : null,
            onSaved: (String value) {
              print(value);
              _creditCardMachine.name = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SizedBox(
              height: 45,
              child: RaisedButton(
                onPressed: _addCreditCardMachine,
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

  ///
  ///
  ///
  void _addCreditCardMachine() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _creditCardMachine.name =
          toBeginningOfSentenceCase(_creditCardMachine.name);
      try {
        if (_creditCardMachine.id == null) {
          await _firestore
              .collection('users')
              .doc(_auth.currentUser.uid)
              .collection('creditCardMachines')
              .add(_creditCardMachine.toMap());
        } else {
          await _firestore
              .collection('users')
              .doc(_auth.currentUser.uid)
              .collection('creditCardMachines')
              .doc(_creditCardMachine.id)
              .update(_creditCardMachine.toMap());
        }

        await DisplayAlert.show(
          context: context,
          title: 'Sucesso',
          message: 'Máquina de cartão adicionada com sucesso.',
        );
      } catch (e) {
        await DisplayAlert.show(
          context: context,
          title: 'Erro',
          message: 'Falha ao cadastrar a máquina.\n'
              'Por favor, tente mais tarde.',
        );
      }

      Navigator.of(context).pop();
    }
  }
}
