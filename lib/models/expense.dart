import 'package:meu_caixa_flutter/models/supplier.dart';

///
///
///
class Expense {
  String id;
  String description;
  double value;
  Supplier supplier;

  ///
  ///
  ///
  Expense();

  ///
  ///
  ///
  Expense.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        description = map['description'],
        value = map['value'];

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['description'] = description;
    map['value'] = value;
    if (supplier != null && supplier.name != null) {
      map['supplierName'] = supplier.name;
    }
    return map;
  }
}
