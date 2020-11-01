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

  /// TODO Esse é o estilo padrão do NewDefaultTextField, não sei se esse é o
  /// jeito correto de colocar dentro do Config. Verificar
  InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(),
    counterText: '',
  );

  ///
  ///
  ///
  Config._internal();
}
