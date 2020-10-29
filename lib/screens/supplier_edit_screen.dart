import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/supplier.dart';

///
///
///
class SupplierEditScreen extends StatefulWidget {
  final Supplier supplier;

  ///
  ///
  ///
  const SupplierEditScreen({Key key, this.supplier}) : super(key: key);

  ///
  ///
  ///
  @override
  _SupplierEditScreenState createState() => _SupplierEditScreenState();
}

///
///
///
class _SupplierEditScreenState extends State<SupplierEditScreen> {
  Supplier supplier;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    supplier = widget.supplier ?? Supplier();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
