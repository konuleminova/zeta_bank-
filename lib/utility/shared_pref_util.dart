import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static String isLoginKey = "User has login";
  static String smsOtpCode = "sms Code";
  static String smsOtpId = "sms OTp id";
  static String accessToken = "Access token";
  static String userId = "User id";

  Future<String> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<int> getInt(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  setInt(String key, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value);
  }
}
