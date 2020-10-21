import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/screens/add_credit_card_machine_screen.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_screen.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

class CreditCardScreen extends StatefulWidget {
  static String screenId = "CreditCardScreen";
  final CashRegistry cashRegistry;
  CreditCardScreen({@required this.cashRegistry});
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  FirebaseFirestore _firestore;
  List<DefaultTextField> creditCardMachineList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  void dispose() {
    super.dispose();
  }

  var scieloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var steloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  CashRegistry _cashRegistry = CashRegistry();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Cartões de crédito"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Color(0x00FFFFFF),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
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
                children: [
                  StreamBuilder(
                    stream: _firestore
                        .collection('creditCardMachines')
                        .where("userId",
                            isEqualTo: UserUtils.getCurrentUser().uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }
                      final machinesSnapshot = snapshot.data.docs;
                      creditCardMachineList = [];
                      widget.cashRegistry.creditCardMachineList = [];
                      for (var machine in machinesSnapshot.reversed) {
                        var m = machine.data();
                        final CreditCardMachine creditCardMachine =
                            CreditCardMachine();
                        if (m['name'] != null) {
                          creditCardMachine.name = m['name'];
                          creditCardMachine.controller =
                              MoneyMaskedTextController(
                                  thousandSeparator: '.',
                                  decimalSeparator: ',');
                          print(m);
                          final defaultTextField = DefaultTextField(
                            hintText: creditCardMachine.name,
                            controller: creditCardMachine.controller,
                          );
                          creditCardMachineList.add(defaultTextField);
                          widget.cashRegistry.creditCardMachineList
                              .add(creditCardMachine);
                        }
                      }
                      return Column(
                        children: creditCardMachineList,
                      );
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CashRegistryScreen(
                              cashRegistry: widget.cashRegistry),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Avançar"),
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
