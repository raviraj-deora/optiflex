import 'package:flutter/material.dart';

import 'calculate.dart';

class HomeScreen extends StatelessWidget {

  void selectPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Calculate();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Optiflex Calculators')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 18.0),
          ),
          // Image.asset('assets/images/phakic-check-type.png'),
          GestureDetector(
            onTap: () {
              selectPage(context);
            }, // handle your image tap here
            child: Image.asset(
              'assets/images/phakic-check-type.png',
              fit: BoxFit.cover, // this is the solution for border
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18.0),
          ),
        ],
      ),
    );
  }
}