import 'package:flutter/material.dart';
import 'package:zeta_bank/bank_accounts.dart';
import 'package:zeta_bank/home.dart';
import 'package:zeta_bank/login.dart';
import 'package:zeta_bank/my_bills.dart';
import 'package:zeta_bank/pin_code.dart';
import 'package:zeta_bank/pin_code_new.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:LoginPage(),
      routes: {
        "/login": (context) => LoginPage(),
        "/pincode": (context) => PinCodePage(),
        "/home": (context) => HomePage(),
        "/bank_accounts": (context) => BankAccountsPage(),
        "/my_bills": (context) => MyBillsPage()
      },
    );
  }
}
