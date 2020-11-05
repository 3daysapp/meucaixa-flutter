import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

///
///
///
void main() {
  final CashRegistry cashRegistry = CashRegistry();
  final List<Expense> expenseList = <Expense>[];
  final List<CreditCardMachine> creditCardMachineList = <CreditCardMachine>[];

  for (int i = 0; i < 2; i++) {
    CreditCardMachine creditCardMachine = CreditCardMachine();
    creditCardMachine.value = 89.50;
    creditCardMachineList.add(creditCardMachine);
  }

  for (int i = 0; i < 2; i++) {
    Expense exp = Expense();
    exp.value = 100;
    expenseList.add(exp);
  }

  cashRegistry.creditCardMachineList = creditCardMachineList;
  cashRegistry.expenseList = expenseList;
  cashRegistry.openValue = 264;
  cashRegistry.note2 = 25;
  cashRegistry.note5 = 10;
  cashRegistry.note10 = 5;
  cashRegistry.note50 = 1;
  cashRegistry.note100 = 2;
  cashRegistry.calculate();

  test('Total de despesas', () {
    expect(cashRegistry.getTotalExpenses, 200);
  });

  test('Total Cartão de credito', () {
    expect(cashRegistry.getTotalCreditCardMachine, 179);
  });

  test('Total Dinheiro', () {
    expect(cashRegistry.getTotalMoney, 400);
  });

  test('Fechamento total do caixa', () {
    expect(cashRegistry.total, 643);
  });
}
