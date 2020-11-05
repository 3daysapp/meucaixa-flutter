import 'package:flutter_masked_text/flutter_masked_text.dart';

///
///
///
class CreditCardMachine {
  String name;
  String id;
  double value;

  ///
  ///
  ///
  CreditCardMachine();

  ///
  ///
  ///
  CreditCardMachine.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        name = map['name'],
        value = map['value'];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }
}
