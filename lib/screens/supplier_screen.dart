import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';
import 'package:meu_caixa_flutter/screens/supplier_edit_screen.dart';

///
///
///
class ProviderScreen extends StatefulWidget {
  static String screenId = 'providerScreen';

  ///
  ///
  ///
  const ProviderScreen({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

///
///
///
class _ProviderScreenState extends State<ProviderScreen> {
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
                .collection('providers')
                // .where('userId', isEqualTo: UserUtils.getCurrentUser().uid)
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> docs = snapshot.data.docs;
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
    bool delete = await DisplayAlert.yesNo(
      context: context,
      message: 'Deseja excluir o fornecedor ${supplier.name}?',
    );

    if (delete) {
      try {
        await _firestore.collection('providers').doc(supplier.id).delete();

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
