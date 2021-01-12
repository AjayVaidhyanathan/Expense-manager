import 'package:flutter/cupertino.dart';

class Calculations extends ChangeNotifier {
  int income = 0;
  int expense = 0;
  int total = 0;

  int get getIncome => income;
  int get getExpense => expense;
  int get getTotal => total;

  int totalExpense(BuildContext context, AsyncSnapshot snapshot) {
    for (int i = 0; i < snapshot.data.documents.length; i++) {
      if (snapshot.data.documents[i].data()['income'] == false) {
        expense = expense + snapshot.data.documents[i].data()['expense'];
        print(expense);
      } else {
        continue;
      }
    }
    notifyListeners();
    return expense;
  }

  int totalIncome(BuildContext context, AsyncSnapshot snapshot) {
    for (int i = 0; i < snapshot.data.documents.length; i++) {
      if (snapshot.data.documents[i].data()['income'] == true) {
        income = income + snapshot.data.documents[i].data()['expense'];
        print(income);
      } else {
        continue;
      }
    }
    return income;
  }

  int totalValue(int income, int expense) {
    if (income > expense) {
      total = income - expense;
    } else {
      total = expense - income;
    }

    return total;
  }
}
