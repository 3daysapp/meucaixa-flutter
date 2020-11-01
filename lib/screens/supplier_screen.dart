import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';
import 'package:meu_caixa_flutter/screens/supplier_edit_screen.dart';

///
///
///
class SupplierScreen extends StatefulWidget {
  ///
  ///
  ///
  const SupplierScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

///
///
///
class _SupplierScreenState extends State<SupplierScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fornecedores'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => SupplierEditScreen(),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .doc(_auth.currentUser.uid)
                .collection('suppliers')
                .where('isActive', isEqualTo: true)
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> docs = snapshot.data.docs;

                if (docs.isEmpty) {
                  return Center(
                    child: Text('Nenhum fornecedor cadastrado '
                        'até o momento.'),
                  );
                }

                return ListView.separated(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot doc = docs[index];
                    Supplier supplier = Supplier.fromMap(doc.id, doc.data());
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.circle),
                        ],
                      ),
                      title: Text(supplier.name),
                      subtitle: Text(supplier.telephone),
                      tileColor: Colors.teal,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) => SupplierEditScreen(
                            supplier: supplier,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _delete(supplier),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _delete(Supplier supplier) async {
    print(supplier.id);
    bool delete = await DisplayAlert.yesNo(
      context: context,
      message: 'Deseja excluir o fornecedor ${supplier.name}?',
    );

    if (delete) {
      try {
        // await _firestore.collection('providers').doc(supplier.id).delete();

        supplier.isActive = false;

        await _firestore
            .collection('users')
            .doc(_auth.currentUser.uid)
            .collection('suppliers')
            .doc(supplier.id)
            .update(supplier.toMap());

        await DisplayAlert.show(
          context: context,
          title: 'Sucesso',
          message: 'Fornecedor excluído com sucesso.',
        );
      } catch (e) {
        await DisplayAlert.show(
          context: context,
          title: 'Erro',
          message: 'Falha ao excluir o fornecedor.\n'
              'Por favor, tente mais tarde.',
        );
      }
    }
  }
}
