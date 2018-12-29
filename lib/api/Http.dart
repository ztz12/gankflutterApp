import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:gankflutter/api/Api.dart';
import 'package:gankflutter/model/DailyResponse.dart';

class HttpExt {
  static void get(String url, Function callback, Function errorCallback) async {
    try {
      http.Response res = await http.get(url);
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String url,Function callback,{Map<String,dynamic> params,Function errorCallback}) async{
    try{
      http.Response response = await http.post(url,body: params);
      if(callback!=null){
        callback(response);
      }
    }catch(exception){
      if(errorCallback!=null){
        errorCallback(exception);
      }
    }
  }

  static Future<String> getRequest(String url,[Map params]) async{
     http.Response response = await http.get(url,headers: params);
     return response.body.toString();
  }

  static Future<CategoryResponse> getGankData(String url) async{
    final String responseStr = await getRequest(url);
    return toGankList(responseStr);
  }
  static CategoryResponse toGankList(String responseStr){
    return CategoryResponse.fromJson(jsonDecode(responseStr));
  }

  static Future<Response> login(String username, String password) async {
    FormData formData =
        new FormData.from({"username": "$username", "password": "$password"});
    return await Dio().post(Api.LOGIN, data: formData);
  }

  Future<Response> register(
      String username, String password, String repassword) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$password",
      "repassword": "$repassword"
    });
    return Dio().post(Api.REGISTER, data: formData);
  }
}
