import 'package:expense_tracker/Screens/signin_page.dart';
import 'package:expense_tracker/Screens/transaction.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:expense_tracker/Widgets/home_widgets.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle),
          title: Text("Overview"),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  AuthService().signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                })
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              OverviewCard(
                balance: '\$3000',
                income: '\$1000',
                expense: '\$500',
              ),
              SizedBox(height: 25),
              DateCard(
                date: "Monday, 11 January 2021",
              ),
              SizedBox(height: 5),
              TransactionCard(
                description: "Clothes for diwali",
                category: "Clothes",
                cost: "\$22",
                color: Colors.green,
              ),
              SizedBox(height: 5),
              TransactionCard(
                description: "Shawarma",
                category: "Food",
                cost: "\$12",
                color: Colors.redAccent,
              ),
              SizedBox(height: 5),
              DateCard(
                date: "Monday, 2 January 2021",
              ),
              SizedBox(height: 5),
              TransactionCard(
                description: "Clothes for diwali",
                category: "Clothes",
                cost: "\$22",
                color: Colors.green,
              ),
              SizedBox(height: 5),
              TransactionCard(
                description: "Shawarma",
                category: "Food",
                cost: "\$12",
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Transaction',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Transaction()));
            print(AuthService().getUserUid());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
