// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:optiflexcalculator/login/model/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.s,
    this.m,
    this.r,
  });

  int s;
  String m;
  User r;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    s: json["s"],
    m: json["m"],
    r: json["r"]==null?null:User.fromJson(json["r"]),
  );

  Map<String, dynamic> toJson() => {
    "s": s,
    "m": m,
    "r": r.toJson(),
  };
}


