///
///
///
class CreditCardMachine {
  String id;
  String name;
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

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (value != null) map['value'] = value;
    return map;
  }
}
