import 'package:meu_caixa_flutter/interfaces/i_repository.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';

class CaixaRepository implements IRepository<CashRegistry> {
  @override
  Future add<Caixa>(Caixa entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future list<Caixa>(Function callback) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future select<Caixa>(int entityPrimaryKey) {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future update<Caixa>(Caixa entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
