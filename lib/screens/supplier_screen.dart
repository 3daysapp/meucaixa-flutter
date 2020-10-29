import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:meu_caixa_flutter/components/add_anything.dart';
// import 'package:meu_caixa_flutter/components/default_text_field.dart';
// import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

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

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final Supplier provider = Supplier();

  ///
  ///
  ///
  // void addProvider(BuildContext context) async {
  //   try {
  //     await _firestore.collection('providers').add({
  //       'userId': UserUtils.getCurrentUser().uid,
  //       'name': provider.name,
  //       'telephone': provider.telephone,
  //     });
  //     showAlertDialog(
  //       context: context,
  //       title: 'Sucesso',
  //       message: 'Fornecedor cadastrado com sucesso',
  //       actions: [
  //         FlatButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('OK'),
  //         )
  //       ],
  //     );
  //   } catch (e) {
  //     showAlertDialog(
  //       context: context,
  //       title: 'Erro',
  //       message:
  //           'Falha ao cadastrar o fornecedor, por favor, tente mais tarde.',
  //       actions: [
  //         FlatButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('OK'),
  //         )
  //       ],
  //     );
  //   }
  // }

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
          onPressed: () {},
          // onPressed: () {
          //   showModalBottomSheet(
          //     backgroundColor: Colors.transparent,
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) => SingleChildScrollView(
          //       padding: EdgeInsets.only(
          //         bottom: MediaQuery.of(context).viewInsets.bottom,
          //       ),
          //       child: AddAnything(
          //         children: [
          //           Form(
          //             key: _formKey,
          //             child: Padding(
          //               padding: const EdgeInsets.only(bottom: 15),
          //               child: Text(
          //                 'Cadastrar fornecedor',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           DefaultTextField(
          //             hintText: 'Nome',
          //             callback: (value) => provider.name = value,
          //             validator: (value) {
          //               if (value.isEmpty) {
          //                 return 'Por favor, informe o nome do fornecedor';
          //               }
          //               return null;
          //             },
          //           ),
          //           DefaultTextField(
          //             hintText: 'Telefone',
          //             callback: (value) => provider.telephone = value,
          //           ),
          //           Padding(
          //             padding:
          //                 const EdgeInsets.only(left: 20, right: 20, top: 10),
          //             child: SizedBox(
          //               height: 45,
          //               child: RaisedButton(
          //                 onPressed: () {
          //                   addProvider(context);
          //                 },
          //                 color: Colors.teal,
          //                 elevation: 5,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 child: Text('Cadastrar fornecedor'),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // },
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('providers')
                .where('userId', isEqualTo: UserUtils.getCurrentUser().uid)
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
                      leading: Icon(Icons.circle),
                      title: Text(supplier.name),
                      subtitle: Text(supplier.telephone),
                      tileColor: Colors.teal,
                      onTap: () {},
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
}
