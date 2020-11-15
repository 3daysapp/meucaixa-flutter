import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///
///
class Config {
  static final Config _singleton = Config._internal();

  static const String releaseDate = '25/10/2020';

  static const Color richBlackColor = Color(0xFF011627);
  static const Color radicalRedColor = Color(0xFFFF3366);
  static const Color tiffanyBlueColor = Color(0xFF2EC4B6);
  static const Color culturedColor = Color(0xFFF6F7F8);
  static const Color carolinaColor = Color(0xFF20A4F3);

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
