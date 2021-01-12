import 'package:expense_tracker/Screens/signin_page.dart';
import 'package:expense_tracker/Screens/transaction.dart';
import 'package:expense_tracker/Services/Calculations.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:expense_tracker/Services/database.dart';
import 'package:expense_tracker/Widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool expense;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Provider.of<MiddleContent>(context).middleData(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Transaction',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Transaction()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MiddleContent extends ChangeNotifier {
  Widget headerData(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      children: [
        OverviewCard(
          balance: Provider.of<Calculations>(context, listen: true).totalValue(
              Provider.of<Calculations>(context, listen: true).income,
              Provider.of<Calculations>(context, listen: true).expense),
          income: Provider.of<Calculations>(context, listen: true)
              .totalIncome(context, snapshot),
          expense: Provider.of<Calculations>(context, listen: true)
              .totalExpense(context, snapshot),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget middleData(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<DatabaseServices>(context, listen: false)
            .fetchData(context, '2020'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Text('No Transactions'),
              ),
            );
          }

          return Column(
            children: [
              headerData(context, snapshot),
              SizedBox(height: 10),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        DateCard(
                          date: snapshot.data.documents[index]
                              .data()['Formated_Date'],
                        ),
                        SizedBox(height: 5),
                        TransactionCard(
                          description: snapshot.data.documents[index]
                              .data()['description'],
                          category:
                              snapshot.data.documents[index].data()['category'],
                          cost: snapshot.data.documents[index]
                              .data()['expense']
                              .toString(),
                          color: snapshot.data.documents[index].data()['income']
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    );
                  }),
            ],
          );
        });
  }
}
