import 'package:expense_tracker/Screens/signin_page.dart';
import 'package:expense_tracker/Screens/transaction.dart';
import 'package:expense_tracker/Services/Calculations.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:expense_tracker/Services/database.dart';
import 'package:expense_tracker/Widgets/home_widgets.dart';
import 'package:expense_tracker/Widgets/transaction_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool expense;

  @override
  void initState() {
    Provider.of<MiddleContent>(context, listen: false).distinctdates.clear();
    Provider.of<Calculations>(context, listen: false).isIncome = true;
    Provider.of<Calculations>(context, listen: false).isExpense = true;
    Provider.of<Calculations>(context, listen: false).isTotal = true;
    super.initState();
  }

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
  bool nextdate;
  List<String> dates = List<String>();
  List<String> distinctdates = List<String>();
  Widget headerData(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      children: [
        OverviewCard(),
        SizedBox(height: 25),
      ],
    );
  }

  Widget middleData(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<DatabaseServices>(context, listen: true)
            .fetchData(context, '2021'),
        builder: (context, allsnapshot) {
          if (!allsnapshot.hasData) {
            return CircularProgressIndicator();
          }
          printDate(context, allsnapshot);
          return Column(
            children: [
              headerData(context, allsnapshot),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<MiddleContent>(context, listen: false)
                      .distinctdates
                      .length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        DateCard(date: distinctdates[index]),
                        StreamBuilder(
                            stream: Provider.of<DatabaseServices>(context,
                                    listen: true)
                                .orderByDate(
                                    context, '2021', distinctdates[index]),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      children: [
                                        TransactionCard(
                                          description: snapshot
                                              .data.documents[i]
                                              .data()['description'],
                                          category: snapshot.data.documents[i]
                                              .data()['category'],
                                          cost: snapshot.data.documents[i]
                                              .data()['expense']
                                              .toString(),
                                          color: snapshot.data.documents[i]
                                                  .data()['income']
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  });
                            })
                      ],
                    );
                  }),
            ],
          );
        });
  }

  printDate(BuildContext context, AsyncSnapshot snapshot) {
    for (int index = 0; index < snapshot.data.documents.length; index++) {
      String date = snapshot.data.documents[index].data()['Formated_Date'];
      dates.add(date);
      distinctdates = dates.toSet().toList();
      print(distinctdates.toString());
    }
  }
}
