import 'package:flutter/material.dart';
import 'package:pin_code_view/code_view.dart';
import 'package:pin_code_view/custom_keyboard.dart';
import 'package:zeta_bank/model/login_response.dart';
import 'package:zeta_bank/service/networks.dart';

class PinCodePage extends StatefulWidget {
  LoginResponse response;

  PinCodePage({this.response});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PinCodeState();
  }
}

class PinCodeState extends State<PinCodePage> {
  TextStyle codeTextStyle, keyTextStyle;
  String smsCode = "";
  LoginResponse response;

  @override
  void initState() {
    super.initState();
    response = widget.response;
    smsCode = response.smsOtpCode;
  }

  @override
  Widget build(BuildContext context) {
    this.codeTextStyle = const TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold);
    this.keyTextStyle = const TextStyle(color: Colors.black87, fontSize: 25.0);
    // TODO: implement build
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[300]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CodeView(
              codeTextStyle: codeTextStyle,
              code: smsCode,
              obscurePin: false,
              length: 6),
          SizedBox(
            height: 16.0,
          ),
          CustomKeyboard(
            textStyle: keyTextStyle,
            onPressedKey: (key) {
              if (smsCode.length < 6) {
                setState(() {
                  smsCode = smsCode + key;
                });
              }
              if (smsCode.length == 6) {
                Networks.checkPin(response.smsOtpId, response.smsOtpCode,
                    response.accessToken, context);
              }
            },
            onBackPressed: () {
              int codeLength = smsCode.length;
              if (codeLength > 0)
                setState(() {
                  smsCode = smsCode.substring(0, codeLength - 1);
                });
            },
          ),
        ],
      ),
    ));
  }
}
