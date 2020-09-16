

import 'dart:convert';

import 'package:optiflexcalculator/login/model/user.dart';
import 'package:optiflexcalculator/utils/preferences.dart';
import 'package:optiflexcalculator/utils/url_utils.dart';

import 'login/model/login_model.dart';
import 'main.dart';

class RestDatasource {

  Future<LoginResponse> onResponseLogin(String username, String password) async {
    try{
      Map<String, dynamic> body = {
        "username": username,
        "password": password
      };
      dynamic response = await netUtil.post(url:URL_login, body: body);
      print("response = $response");
      LoginResponse loginResponse = LoginResponse.fromJson(json.decode(response.toString()));
      print("loginResponse = ${loginResponse.s}");

      if(loginResponse.s == 1){
        user = loginResponse.r;
        if(user!=null){
          print("username = ${user.uname}");
          user = loginResponse.r;
          Preferences.setString(Preferences.PF_USER_LOGIN,json.encode(loginResponse));
          await Preferences.getString(Preferences.PF_USER_LOGIN).then((data)
          {
            print("api data = $data");
//            if (data != null) {
//              LoginResponse loginResponse = LoginResponse.fromJson(json.decode(data));
//              user = loginResponse.r;
//            }
//            return loginResponse;
          });
        }
      }

    }catch(stack,error){
      print("stack1 = $stack");
    }
    return null;
//    await netUtil.post(url: URL_login, body: body).then((dynamic res) async {
//      print("res = $res");
//      LoginResponse response = new LoginResponse.fromJson(json.decode(res));
//      print("response = $response");
//
//      if (response.s != 1) {
//        //throw new Exception(response.m);
//      }
//      else {
//        Preferences.setString(Preferences.PF_USER_LOGIN,json.encode(response));
//        await Preferences.getString(Preferences.PF_USER_LOGIN).then((data)
//        {
//          print("api data = $data");
//          if (data != null) {
//            LoginResponse loginResponse = LoginResponse.fromJson(json.decode(data));
//            user = loginResponse.r;
//          }
//        });
//        return new LoginResponse.fromJson(res);
//      }
//    });}catch(stack,error){
//      print("error = $error");
//      print("stack1 = $stack");
//    }
  }
}