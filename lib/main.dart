import 'package:expense_tracker/Screens/home.dart';
import 'package:expense_tracker/Screens/signin_page.dart';
import 'package:expense_tracker/Services/Calculations.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:expense_tracker/Services/database.dart';
import 'package:expense_tracker/Widgets/transaction_widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthService()),
        ChangeNotifierProvider.value(value: DatePicker()),
        ChangeNotifierProvider.value(value: DatabaseServices()),
        ChangeNotifierProvider.value(value: Calculations()),
        ChangeNotifierProvider.value(value: MiddleContent()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage(),
      ),
    );
  }
}
