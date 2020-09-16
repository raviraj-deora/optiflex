import 'package:flutter/material.dart';

import 'app_colors.dart';

class RedirectToLogin extends StatefulWidget {
  @override
  _RedirectToLoginState createState() => _RedirectToLoginState();
}

class _RedirectToLoginState extends State<RedirectToLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You have to login first",style: TextStyle(color: AppColors.themeColor),),
          SizedBox(height: 10,),
          RaisedButton(
            color: AppColors.themeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => LoginSignupSelectionScreeen(),
//                ),
//              );
            },
            child: Text("Login",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
