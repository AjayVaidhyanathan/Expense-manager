import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Calculations extends ChangeNotifier {
  int income = 0;
  int expense = 0;
  int total = 0;
  bool isIncome = false;
  bool isExpense = false;
  bool isTotal = false;

  int get getIncome => income;
  int get getExpense => expense;
  int get getTotal => total;
  bool get getisIncome => isIncome;
  bool get getisExpense => isExpense;
  bool get getisTotal => isTotal;

  totalExpense(BuildContext context, int amount) {
    expense = expense + amount;
    isExpense = true;
    notifyListeners();
  }

  totalIncome(BuildContext context, int amount) {
    income = income + amount;
    isIncome = true;
    notifyListeners();
  }

  totalValue(BuildContext context) {
    if (income > expense) {
      total = income - expense;
    } else {
      total = expense - income;
    }
    isTotal = true;
    notifyListeners();
  }
}
