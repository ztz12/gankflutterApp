import 'package:shared_preferences/shared_preferences.dart';

class SharePrefUtils{
  static saveString(String key,value)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static saveList(String key,List<String> list) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, list);
  }

  static get(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  static remove(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}