import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/new_default_textfield.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/screens/add_credit_card_machine_screen.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_screen.dart';

///
///
///
class CreditCardScreen extends StatefulWidget {
  static String screenId = 'CreditCardScreen';
  final CashRegistry cashRegistry;

  ///
  ///
  ///
  const CreditCardScreen({
    Key key,
    @required this.cashRegistry,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

///
///
///
class _CreditCardScreenState extends State<CreditCardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<MoneyMaskedTextController> creditCardMachineControllerList =
      <MoneyMaskedTextController>[];

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cartões de Crédito'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddCreditCardMachineScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('users')
                        .doc(_auth.currentUser.uid)
                        .collection('creditCardMachines')
                        .snapshots(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }

                      final List<QueryDocumentSnapshot> machines =
                          snapshot.data.docs;

                      widget.cashRegistry.creditCardMachineList =
                          <CreditCardMachine>[];
                      final List<NewDefaultTextField> creditCardMachineList =
                          <NewDefaultTextField>[];

                      for (QueryDocumentSnapshot machine in machines.reversed) {
                        Map<String, dynamic> machineData = machine.data();

                        final CreditCardMachine creditCardMachine =
                            CreditCardMachine();

                        if (machineData['name'] != null) {
                          creditCardMachine.name = machineData['name'];

                          /// TODO Tirei o controller de dentro do model
                          /// Agora, é preciso achar uma maneira de recuperar
                          /// o valor digitado pelo usuário
                          MoneyMaskedTextController controller =
                              MoneyMaskedTextController(
                                  decimalSeparator: ',',
                                  thousandSeparator: '.');

                          final NewDefaultTextField defaultTextField =
                              NewDefaultTextField(
                            labelText: creditCardMachine.name,
                            controller: controller,
                          );
                          creditCardMachineList.add(defaultTextField);
                          creditCardMachineControllerList.add(controller);

                          widget.cashRegistry.creditCardMachineList
                              .add(creditCardMachine);
                        }
                      }

                      return Column(
                        children: creditCardMachineList,
                      );
                    },
                  ),

                  /// TODO - O que acha de jogar no actions do AppBar?
                  FlatButton(
                    onPressed: () {
                      int index = 0;
                      for (CreditCardMachine machine
                          in widget.cashRegistry.creditCardMachineList) {
                        machine.value =
                            creditCardMachineControllerList[index].numberValue;
                        index++;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute<CashRegistryScreen>(
                          builder: (BuildContext context) => CashRegistryScreen(
                            cashRegistry: widget.cashRegistry,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Avançar'),
                        Icon(Icons.arrow_right_outlined),
                      ],
                    ),
                    color: Colors.blueAccent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
