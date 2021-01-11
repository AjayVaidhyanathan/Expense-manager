import 'package:expense_tracker/Services/auth.dart';
import 'package:expense_tracker/Widgets/signin_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SignInButton(onPressed: () {
              AuthService().signInWithGoogle(context);
            })
          ],
        ),
      ),
    );
  }
}
