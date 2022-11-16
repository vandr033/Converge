import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
//keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = 'EMAILKEY';

  //saving data
  static Future<bool> saveUserLoggedInStatus(bool isuserloggeIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isuserloggeIn);
  }

  static Future<bool> saveUserNameInStatus(String username) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, username);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  //getting data
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUsername() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}
