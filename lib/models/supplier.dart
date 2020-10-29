import 'package:meu_caixa_flutter/utils/user_utils.dart';

///
///
///
class Supplier {
  String id;
  String name;
  String telephone;
  String userId; // FIXME - Remover este atributo devido a estrutura do firebase.

  ///
  ///
  ///
  Supplier();

  ///
  ///
  ///
  Supplier.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        name = map['name'],
        telephone = map['telephone'],
        userId = map['userId'];

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (telephone != null) map['telephone'] = telephone;

    // FIXME - Remover estre atributo.
    map['userId'] = UserUtils.getCurrentUser().uid;

    return map;
  }
}
