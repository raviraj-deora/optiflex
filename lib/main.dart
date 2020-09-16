import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:optiflexcalculator/splash_screen.dart';
import 'package:optiflexcalculator/utils/app_colors.dart';
import 'package:optiflexcalculator/utils/network_util.dart';
import 'package:optiflexcalculator/utils/routes.dart';
import './calculate.dart';
import 'AgrreeAndContinue/agree_and_continue_screen.dart';
import 'login/login_view.dart';
import 'login/model/user.dart';

Network netUtil = new Network();
User user;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: AppColors.themeColor,
          accentColor: AppColors.themeColor,
      ),
      //home: LoginSignupSelectionScreeen(),
      routes: routes,
//      home: Scaffold(
//        body: AgreeAndContinueScreen(),
//      ),
    );
  }
}