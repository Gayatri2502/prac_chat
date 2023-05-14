import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  // keys
  static const userLoggedInKey = "LOGGED_IN_KEY ";
  static const userNameKey = "USER_NAME_KEY ";
  static const userEmailKey = "USER_EMAIL_KEY ";

  //Saving  the data to SF
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedInStatus) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoggedInKey, isUserLoggedInStatus);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, userEmail);
  }

  //getting the data to SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}
