///
///
///
class AppUser {
  String id;
  String email;
  String name;

  ///
  ///
  ///
  AppUser({this.email, this.name});

  ///
  ///
  ///
  AppUser.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        name = map['name'],
        email = map['email'];

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['emal'] = email;

    return map;
  }
}
