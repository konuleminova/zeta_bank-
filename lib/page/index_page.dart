import 'package:flutter/material.dart';
import 'package:zeta_bank/page/login.dart';
import 'package:zeta_bank/widget/pin_code_screen.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLoggedIn = false;
  bool progress = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
        future: SharedPrefUtil().getString(SharedPrefUtil.accessToken),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "") {
              return PinCodeScreen();
            } else {
              return LoginPage();
            }
          } else {
            // default show loading while state is waiting
            return  new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
