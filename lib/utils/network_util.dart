import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optiflexcalculator/utils/url_utils.dart';


class Network {
  static Dio dio = new Dio(
    BaseOptions(
      baseUrl: MAIN_URL,
    ),
  );

  static Network _instance = new Network.internal();

  Network.internal();

  factory Network() => _instance;

  String _handleError(error) {
    String message = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          message =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          message =
          "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          message = "Send timeout with API server";
          break;
      }
    } else {
      message = "Unexpected error occured";
    }
    return message;
  }
  Future<dynamic> downloadFile(BuildContext context,{@required String url, path}) {
    return dio
        .download(url, path,
            options: Options(headers: {
//              "apikey": Utils.responseLogIn == null
//                  ? ''
//                  : Utils.responseLogIn.r.apiKey,
//              "token": Utils.responseLogIn == null
//                  ? ''
//                  : Utils.responseLogIn.r.token,
            }),
            onReceiveProgress: onReceiveProgress)
        .then((response) => onResponse(response));
  }

  Future<dynamic> uploadFile(BuildContext context,{@required String url, @required Map body}) {
    return dio
        .post(url,
            options: Options(headers: {

            }),
            data: FormData.fromMap(body),
            onSendProgress: onSendProgress)
        .then((response) => onResponse(response));
  }

  Future<dynamic> post({@required String url, Map body}) {
    print("url = $url");
    print("request body = $body");
    return dio
        .post(url,
            data: FormData.fromMap(body),
            onSendProgress: onSendProgress)
        .then((response) => onResponse(response));
  }

  Future<dynamic> postWithRowData(BuildContext context,{@required String url, @required Map body}) {
    return dio
        .post(url,
            options: Options(headers: {
            }),
            data: json.encode(body),
            onSendProgress: onSendProgress)
        .then((response) => onResponse(response));
  }

  void setData(String apikey,String token) {

    dio.options.headers.addAll({"Apikey": apikey});
    dio.options.headers.addAll({"Token": token});
  }
  void setNewsHeader() {
    dio.options.headers.addAll({"x-rapidapi-host": "contextualwebsearch-websearch-v1.p.rapidapi.com"});
    dio.options.headers.addAll({"x-rapidapi-key": "31ea4ebcfemshf88e0f52a72d8b5p1339ddjsnfa46ceb81612"});
    dio.options.headers.addAll({"useQueryString": "true"});
    dio.options.headers.addAll({"Connection": "keep-alive"});
    dio.options.headers.addAll({"Accept-Encoding": "gzip,deflate,br"});
    dio.options.headers.addAll({"Accept": "*/*"});
    dio.options.headers.addAll({"User-Agent": "PostRuntime/7.27.1"});
  }

  Future<dynamic> get({@required String url}) {
    print("url = $url");
    return dio
        .get(url,
            options: Options(headers: {
            }),
            onReceiveProgress: onReceiveProgress)
        .then((response) => onResponse(response));
  }

  dynamic onResponse(Response response) {
    print("1");
    int code = response.statusCode;
    print("2");
    dynamic data = response.data;
    print("3");
    if(code == 401)
      {
        print("4");
//                  Navigator.of(context).pushNamedAndRemoveUntil(
//              '/login_screen', (Route<dynamic> route) => false);
    }
    else if (code < 200 || code > 400) {
      print("5");
      //throw new Exception("Server Error...");
    }
    print("6");
    return json.decode(json.encode(data));
  }

  void onSendProgress(int sent, int total) {
  }

  void onReceiveProgress(int received, int total) {
  }

}
String handleError(error) {
  String errorDescription = "";
  if (error is DioError) {
    DioError dioError = error as DioError;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
        "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
        "Received invalid status code: ${dioError.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
  } else {
    errorDescription = "Unexpected error occured";
  }
  return errorDescription;
}

