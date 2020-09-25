import 'package:flutter/material.dart';
import 'package:optiflexcalculator/AgrreeAndContinue/agree_and_continue_screen.dart';
import 'package:optiflexcalculator/calculate.dart';
import 'package:optiflexcalculator/calculation_screen.dart';
import 'package:optiflexcalculator/login/login_view.dart';

import '../home_screen.dart';
import '../splash_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginView(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/agree':         (BuildContext context) => new AgreeAndContinueScreen(),
  '/' :          (BuildContext context) => new SplashScreen(),
  //'/login':         (BuildContext context) => new Calculate(),
};