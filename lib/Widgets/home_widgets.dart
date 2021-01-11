import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  const OverviewCard(
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
              Text(balance, style: TextStyle(fontSize: 35)),
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
                Text(income,
                    style: TextStyle(fontSize: 30, color: Colors.green)),
              ],
            ),
            Column(
              children: [
                Text("Expenses", style: TextStyle(color: Colors.grey)),
                Text(expense,
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
          Text(cost, style: TextStyle(fontSize: 25, color: color)),
        ],
      ),
    );
  }
}
