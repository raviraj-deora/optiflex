
import 'dart:convert';

import '../main.dart';
import '../rest_ds.dart';
import 'model/login_model.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LoginResponse response);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();

  LoginScreenPresenter(this._view);

  doLogin(String email, String password) async{
    try
    {
      LoginResponse response= await api.onResponseLogin(email,password);
      _view.onLoginSuccess(response);
    }
    catch (e,stack)
    {
      print("stack = $stack");
      _view.onLoginError(e.toString().substring(e.toString().indexOf(":")+1));

    }
  }
}
