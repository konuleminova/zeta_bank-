import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:zeta_bank/model/login_response.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';
import 'package:pin_code_view/pin_code_view.dart';

class PinCodeScreen extends StatefulWidget {
  LoginResponse response;

  PinCodeScreen({this.response});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PinState();
  }
}

class PinState extends State<PinCodeScreen> {
  LoginResponse response;
  String code = "";

  @override
  void initState() {
    super.initState();
    SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage msg) {
      setState(() {
        code = msg.body.substring(5);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    response = widget.response;
    print(response.smsOtpCode);
    // TODO: implement build
    return Scaffold(
        body: PinCode(
      title: Text(
        "Lock Screen",
        style: TextStyle(
            color: Colors.black87, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      subTitle: Text(
        code,
        style: TextStyle(color: Colors.black87),
      ),
      codeLength: 1,
      correctPin: "1",
      onCodeSuccess: (code) {
        Networks.checkPin(response.smsOtpId, response.smsOtpCode,
            response.accessToken, context);
      },
      onCodeFail: (code) {
        //  print(code);
        //Networks.checkPin(response.smsOtpId,response.smsOtpCode,
        // response.accessToken, context);
      },
    ));
  }
}
