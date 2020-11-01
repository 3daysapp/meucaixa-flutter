import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';

///
///
///
class SupplierEditScreen extends StatefulWidget {
  final Supplier supplier;

  ///
  ///
  ///
  const SupplierEditScreen({Key key, this.supplier}) : super(key: key);

  ///
  ///
  ///
  @override
  _SupplierEditScreenState createState() => _SupplierEditScreenState();
}

///
///
///
class _SupplierEditScreenState extends State<SupplierEditScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Supplier _supplier;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _supplier = widget.supplier ?? Supplier();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fornecedor'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _save,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                /// Name
                /// TODO - Pode usar a implementação do DefaultTextField
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                    initialValue: _supplier.name,
                    validator: (String value) =>
                        value.isEmpty ? 'Informe o nome do fornecedor.' : null,
                    onSaved: (String value) => _supplier.name = value,
                  ),
                ),

                /// Telephone
                /// TODO - Pode usar a implementação do DefaultTextField
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                    initialValue: _supplier.telephone,
                    validator: (String value) => value.isEmpty
                        ? 'Informe o telefone do fornecedor.'
                        : null,
                    onSaved: (String value) => _supplier.telephone = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _save() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        if (_supplier.id == null) {
          await _firestore
              .collection('users')
              .doc(_auth.currentUser.uid)
              .collection('suppliers')
              .add(_supplier.toMap());
        } else {
          await _firestore
              .collection('users')
              .doc(_auth.currentUser.uid)
              .collection('suppliers')
              .doc(_supplier.id)
              .update(_supplier.toMap());
        }

        await DisplayAlert.show(
          context: context,
          title: 'Sucesso',
          message: 'Fornecedor cadastrado com sucesso.',
        );
      } catch (e) {
        await DisplayAlert.show(
          context: context,
          title: 'Erro',
          message: 'Falha ao cadastrar o fornecedor.\n'
              'Por favor, tente mais tarde.',
        );
      }

      Navigator.of(context).pop();
    }
  }
}
