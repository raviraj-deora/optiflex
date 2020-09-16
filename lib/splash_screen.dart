import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:optiflexcalculator/main.dart';
import 'package:optiflexcalculator/utils/preferences.dart';
import 'login/model/login_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    gotoNext();
  }
  gotoNext()
  async {
    await Preferences.getString(Preferences.PF_USER_LOGIN).then((data)
    {
      if (data == null) {
        new Future.delayed(
          const Duration(seconds: 5),
              () => Navigator.pushNamedAndRemoveUntil(
              context, '/login', (_) => false),
        );
      } else {

        LoginResponse loginResponse = LoginResponse.fromJson(json.decode(data));
        user = loginResponse.r;

        if (loginResponse != null) {
          new Future.delayed(
            const Duration(seconds: 5),
                () => Navigator.pushNamedAndRemoveUntil(
                context, '/home', (_) => false),
          );
        }

      }
    });
  }
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splash.png'), fit: BoxFit.cover),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }
}