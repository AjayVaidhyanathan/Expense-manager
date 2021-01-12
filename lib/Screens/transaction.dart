import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Services/database.dart';

import 'package:expense_tracker/Widgets/transaction_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool income = true;

  bool isSwitched = false;
  final number = TextEditingController();
  final description = TextEditingController();
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Transaction"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoriesButton(
                      onPressed: () {
                        setState(() {
                          income = true;
                        });
                      },
                      color: income == true ? Colors.red : Colors.white,
                      textColor: income == true ? Colors.white : Colors.red,
                      text: 'Income',
                    ),
                    SizedBox(width: 20),
                    CategoriesButton(
                      onPressed: () {
                        setState(() {
                          income = false;
                        });
                      },
                      color: income != true ? Colors.red : Colors.white,
                      textColor: income != true ? Colors.white : Colors.red,
                      text: 'Expense',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Select Category"),
                SizedBox(height: 10),
                CategoriesDropDown(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _chosenValue,
                      items: categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                          print(_chosenValue);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Amount"),
                SizedBox(height: 10),
                TransactionInputField(
                    textEditingController: number,
                    keyboardType: TextInputType.number,
                    hintText: 'Input number'),
                SizedBox(height: 10),
                Text("Date"),
                SizedBox(height: 10),
                Provider.of<DatePicker>(context, listen: true)
                    .dateCard(context),
                SizedBox(height: 10),
                Text("Description"),
                SizedBox(height: 10),
                TransactionInputField(
                    textEditingController: description,
                    keyboardType: TextInputType.text,
                    hintText: 'Description'),
                SizedBox(height: 20),
                Center(
                  child: RaisedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      Provider.of<DatabaseServices>(context, listen: false)
                          .addexpense(context, {
                        'expense': int.parse(number.text),
                        'category': _chosenValue,
                        'income': income,
                        'year': Provider.of<DatePicker>(context, listen: false)
                            .selectedDate
                            .year,
                        'month': Provider.of<DatePicker>(context, listen: false)
                            .selectedDate
                            .month,
                        'date': Provider.of<DatePicker>(context, listen: false)
                                .selectedDate
                                .day -
                            1,
                        'description': description.text,
                        'Formated_Date':
                            Provider.of<DatePicker>(context, listen: false)
                                .formatedDate,
                      });
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
