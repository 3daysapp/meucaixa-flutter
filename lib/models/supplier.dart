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
}
