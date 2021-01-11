import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoriesButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Color textColor;
  final String text;

  const CategoriesButton(
      {Key key,
      @required this.onPressed,
      @required this.color,
      @required this.textColor,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red)),
      onPressed: onPressed,
      color: color,
      textColor: textColor,
      child: Text(text.toUpperCase(), style: TextStyle(fontSize: 14)),
    );
  }
}

List<String> categories = [
  'Transport',
  'Travel',
  'Food',
  'Health',
  'Gas',
  'Rent',
  'Car',
  'Education',
  'Fun',
  'Education',
];

class CategoriesDropDown extends StatelessWidget {
  final Widget child;

  const CategoriesDropDown({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[200], width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class TransactionInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String hintText;

  const TransactionInputField(
      {Key key,
      @required this.textEditingController,
      @required this.keyboardType,
      @required this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey[200]),
      ),
      child: TextFormField(
        controller: textEditingController,
        autocorrect: true,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.money_rounded),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
            hintText: hintText),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String formatedDate;
  String defaultDate = new DateFormat.yMMMEd().format(DateTime.now());
  Future<void> _selectDate(BuildContext context) async {
    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (dateTime != null) {
      setState(() {
        formatedDate = new DateFormat.yMMMEd().format(dateTime);
        print(formatedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey[200]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
          ),
          InkWell(
            child: Text(
              formatedDate != null ? formatedDate : defaultDate,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
        ],
      ),
    );
  }
}
