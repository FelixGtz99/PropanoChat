import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String displayNameKey = "USERDISPLAYNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";
  static final PrefsUtil _instance = PrefsUtil._internal();
  factory PrefsUtil() {
    return _instance;
  }
  PrefsUtil._internal();
  SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  //save data
   saveUserName(String getUserName)  {
   
    return _prefs.setString(userNameKey, getUserName);
  }

 saveUserEmail(String getUseremail)  {
    
    return _prefs.setString(userEmailKey, getUseremail);
  }

   saveUserId(String getUserId)  {
   
   _prefs.setString(userIdKey, getUserId);
  }

 saveDisplayName(String getDisplayName)  {
   
    return _prefs.setString(displayNameKey, getDisplayName);
  }

 saveUserProfileUrl(String getUserProfile) {
   
    return _prefs.setString(userProfilePicKey, getUserProfile);
  }

  // get data
   getUserName() {

     _prefs.getString(userNameKey);
  }

 getUserEmail() {
    
    return _prefs.getString(userEmailKey);
  }

  getUserId()  {
   
    return _prefs.getString(userIdKey);
  }

getDisplayName(){
    
    return _prefs.getString(displayNameKey);
  }

getUserProfileUrl()  {
 
    return _prefs.getString(userProfilePicKey);
  }
}