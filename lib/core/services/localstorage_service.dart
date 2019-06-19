import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    
   //SharedPreferences.setMockInitialValues({});

    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  
//   static const String UserKey = 'user';

//   User get user {
//   var userJson = _getFromDisk(UserKey);
//   if (userJson == null) {
//     return null;
//   }

//   return User.fromJson(json.decode(userJson));
// }

// set user(User userToSave) {
//     saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
// }

// dynamic _getFromDisk(String key) {
//   var value  = _preferences.get(key);
//   print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
//   return value;
// }

// void saveStringToDisk(String key, String content){
//   print('(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
//   _preferences.setString(UserKey, content);
// }



}