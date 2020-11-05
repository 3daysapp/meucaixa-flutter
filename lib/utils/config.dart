import 'package:flutter/material.dart';

///
///
///
class Config {
  static final Config _singleton = Config._internal();

  static const String releaseDate = '25/10/2020';

  ///
  ///
  ///
  factory Config() {
    return _singleton;
  }

  bool debug = false;

  ///
  ///
  ///
  Config._internal();
}
