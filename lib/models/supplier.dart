///
///
///
class Supplier {
  String id;
  String name;
  String telephone;

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
        telephone = map['telephone'];

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (telephone != null) map['telephone'] = telephone;

    return map;
  }
}
