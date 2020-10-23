import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/add_anything.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/normal_card.dart';
import 'package:meu_caixa_flutter/models/provider.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

class ProviderScreen extends StatelessWidget {
  static String screenId = "providerScreen";
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Provider provider = Provider();

  void addProvider(BuildContext context) async {
    try {
      await _firestore.collection("providers").add({
        "userId": UserUtils.getCurrentUser().uid,
        "name": provider.name,
        "telephone": provider.telephone,
      });
      showAlertDialog(
        context: context,
        title: "Sucesso",
        message: "Fornecedor cadastrado com sucesso",
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      );
    } catch (e) {
      showAlertDialog(
        context: context,
        title: "Erro",
        message:
            "Falha ao cadastrar o fornecedor, por favor, tente mais tarde.",
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Fornecedores"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
          onPressed: () async {
            showModalBottomSheet(
              backgroundColor: Color(0x00FFFFFF),
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddAnything(
                  childrens: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Cadastrar fornecedor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    DefaultTextField(
                      hintText: 'Nome',
                      callback: (value) => provider.name = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, informe o nome do fornecedor';
                        }
                        return null;
                      },
                    ),
                    DefaultTextField(
                      hintText: 'Telefone',
                      callback: (value) => provider.telephone = value,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: SizedBox(
                        height: 45,
                        child: RaisedButton(
                          onPressed: () {
                            addProvider(context);
                          },
                          color: Colors.teal,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('Cadastrar fornecedor'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                  List<NormalCard> providersList = [];
                  for (var provide in providerSnapshot.reversed) {
                    var p = provide.data();
                    final provider = Provider();
                    if (p['name'] != null) {
                      provider.name = p['name'];
                      provider.telephone = p['telephone'];
                      final providerListTile = NormalCard(
                        title: provider.name,
                        trailing: provider.telephone != null
                            ? provider.telephone
                            : '',
                        color: Colors.teal,
                      );
                      providersList.add(providerListTile);
                    }
                  }
                  return Column(
                    children: providersList,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
