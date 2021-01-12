import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class OverviewCard extends StatelessWidget {
  int balance;
  int income;
  int expense;

  OverviewCard(
      {Key key,
      @required this.balance,
      @required this.income,
      @required this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text("Balance", style: TextStyle(color: Colors.grey)),
              Text(balance.toString(), style: TextStyle(fontSize: 35)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Income", style: TextStyle(color: Colors.grey)),
                Text(income.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.green)),
              ],
            ),
            Column(
              children: [
                Text("Expenses", style: TextStyle(color: Colors.grey)),
                Text(expense.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.redAccent)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class DateCard extends StatelessWidget {
  final String date;

  const DateCard({Key key, @required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Color(0xFFB4B5B6)),
      child: Text(date),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String description;
  final String category;
  final String cost;
  final Color color;

  const TransactionCard(
      {Key key,
      @required this.description,
      @required this.category,
      @required this.cost,
      @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFFFCF1B), Color(0xFFFF881B)])),
                child: Text(
                  category,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.rupeeSign),
              Text(cost, style: TextStyle(fontSize: 25, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}
