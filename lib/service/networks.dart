import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zeta_bank/model/bank_account_item.dart';
import 'package:zeta_bank/model/bank_accounts.dart';
import 'package:zeta_bank/model/login_response.dart';
import 'package:zeta_bank/model/my_bills.dart';
import 'package:zeta_bank/pin_code.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Networks {
  static final String BASE_URL = "http://sps.sinam.net/DemoApi";
  static String LOGIN_ENDPOINT = "/Auth/Login/WithoutSmsOtp";
  static String CHECK_ENDPOINT = "/Auth/SmsOtps/";
  static SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();

  static dynamic login(String username, String password, String deviceToken,
      BuildContext context) async {
    String LOGIN = BASE_URL + LOGIN_ENDPOINT;
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(LOGIN, data: {
        "loginId": username,
        "mobilePinCode": password,
        "deviceToken": deviceToken
      });
      if (response.statusCode == 200) {
        if (response != null) {
          LoginResponse responseL = LoginResponse.fromJson(response.data);
          print("LOGIN!!!" + responseL.accessToken);
          await sharedPrefUtil.setString(
              SharedPrefUtil.accessToken, responseL.accessToken);
          sharedPrefUtil.setString(SharedPrefUtil.smsOtpId, responseL.smsOtpId);
          sharedPrefUtil.setString(
              SharedPrefUtil.smsOtpCode, responseL.smsOtpCode);
          sharedPrefUtil.setInt(SharedPrefUtil.userId, responseL.userId);
          Route route = MaterialPageRoute(
              builder: (context) => PinCodeScreen(
                    response: responseL,
                  ));
          print(responseL.toString());
          Navigator.pushReplacement(context, route);
        }
      } else {
        print("WRONG!!");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Button moved to separate widget'),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (exception) {}
  }

  static dynamic checkPin(String smsOtpId, String otpCode, String token,
      BuildContext context) async {
    String CHECK_PIN = BASE_URL + CHECK_ENDPOINT + "$smsOtpId/Check";
    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${token} "};
      response = await dio.post(CHECK_PIN,
          data: {"otpCode": otpCode}, options: Options(headers: head));
      print("CHECK PIN" + response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response != null) {
          Navigator.pushReplacementNamed(context, "/home");
        }
      } else {
        print("WRONG!!");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Button moved to separate widget'),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (exception) {}
  }

  static dynamic getBankAccounts(BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String BANK_ACCOUNTS = BASE_URL + "/Users/" + "$userId/BankAccounts";
    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response = await dio.get(BANK_ACCOUNTS, options: Options(headers: head));
      print("get BANK ACCOUNTS" + response.toString());
      if (response.statusCode == 200) {
        print(response.data);
        return BankAccounts.fromJson(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic getMyBills(BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String MY_BILLS = BASE_URL + "/Users/" + "$userId/Bills";
    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken}"};
      response = await dio.get(MY_BILLS, options: Options(headers: head));
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
        return MyBills.fromJson(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic payBill(int billId, BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String PAY_BILL = BASE_URL + "/Users/" + "$userId/Bills/$billId/Pay";

    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response = await dio.post(PAY_BILL, options: Options(headers: head));
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic rejectBill(int billId, BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String PAY_BILL = BASE_URL + "/Users/" + "$userId/Bills/$billId/Reject";

    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response = await dio.post(PAY_BILL, options: Options(headers: head));
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic markAsViewed(int billId, BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String MARK_AS_VIEWED =
        BASE_URL + "/Users/" + "$userId/Bills/$billId/MarkAsViewed";

    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response =
          await dio.post(MARK_AS_VIEWED, options: Options(headers: head));
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic activateAccount(
      int bankAccountId, BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    String ACTIVATE =
        BASE_URL + "/Users/" + "$userId/BankAccounts/$bankAccountId/Activate";
    print(ACTIVATE);
    print("ACTIVATEET!!!" + accessToken);
    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response = await dio.post(ACTIVATE, options: Options(headers: head));
      print("!!RESPONSE");
      print(response.toString());
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return false;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic confirmAccount(
      String mobilePushId, BuildContext context) async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String accessToken =
        await sharedPrefUtil.getString(SharedPrefUtil.accessToken);
    int userId = await sharedPrefUtil.getInt(SharedPrefUtil.userId);
    var queryParameters = {
      'userId': userId,
    };
    String CONFIRM =
        BASE_URL + "/Users/$userId" + "/MobilePushes/$mobilePushId/Confirm";
    print(CONFIRM);
    try {
      Response response;
      Dio dio = new Dio();
      var head = {"Authorization": "Bearer ${accessToken} "};
      response = await dio.post(CONFIRM,
          options: Options(headers: head), queryParameters: queryParameters);
      print("!!RESPONSE");
      print(response.toString());
      print("konul" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        return null;
      }
    } catch (exception) {}
  }
}
