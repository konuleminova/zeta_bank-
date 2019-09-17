import 'package:flutter/material.dart';
import 'package:pin_code_view/code_view.dart';
import 'package:pin_code_view/custom_keyboard.dart';
import 'package:pin_code_view/pin_code_view.dart';
import 'package:sms/sms.dart';
import 'package:zeta_bank/model/login_response.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';

class PinCodeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PinCodeState();
  }
}

class PinCodeState extends State<PinCodeScreen> {
  TextStyle codeTextStyle, keyTextStyle;
  String pinCode = "1234";
  //LoginResponse response;

  @override
  void initState() {
    super.initState();
    SharedPrefUtil sharedPrefUtil=new SharedPrefUtil();
    sharedPrefUtil.getString(SharedPrefUtil.pinCode).then((onValue){
     setState(() {
       pinCode=onValue;
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    this.codeTextStyle = const TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold);
    this.keyTextStyle = const TextStyle(color: Colors.black87, fontSize: 25.0);
    // TODO: implement build
    return  Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[300]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: PinCode(
        title: Text(
          "Enter PIN number",
          style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
        ),
        subTitle: Text(
          "Lock Screen",
          style: TextStyle(color: Colors.blueAccent),
        ),
        obscurePin: true,
        correctPin: pinCode,
        // to make pin * instead of number
        codeLength: 4,
        onCodeSuccess: (code) {
          print(code);
          Navigator.pushReplacementNamed(context, "/home");
        },
        onCodeFail: (code) {
          print(code);
        },
      ),
    );
  }
}
