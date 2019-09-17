import 'package:flutter/material.dart';
import 'package:zeta_bank/page/bank_accounts.dart';
import 'package:zeta_bank/page/home.dart';
import 'package:zeta_bank/page/index_page.dart';
import 'package:zeta_bank/page/login.dart';
import 'package:zeta_bank/page/my_bills.dart';
import 'package:zeta_bank/widget/pin_code_screen.dart';
import 'package:zeta_bank/page/pin_code_page.dart';

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
      home:IndexPage(),
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
