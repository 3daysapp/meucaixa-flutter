import 'package:flutter/cupertino.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/credit_card_registry.dart';

class CreditCardTextfield extends StatelessWidget {
  final CreditCardMachine creditCardMachine;
  final CreditCardRegistry creditCardRegistry;
  CreditCardTextfield(
      {@required this.creditCardMachine, @required this.creditCardRegistry});
  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      hintText: creditCardMachine.name,
      callback: (value) => creditCardRegistry.value = value,
    );
  }
}
