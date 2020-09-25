import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class Common {
  static Widget headingWidget(String text){
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: AppColors.themeGreyColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text.toUpperCase(),
            style: TextStyle(color:AppColors.themeColor)),
      ),
    );
  }
  static void showErrorToastMsg(String txt) {
    Fluttertoast.showToast(
        msg: "$txt",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }
  static Widget loginButton(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: OutlineButton(
          color: AppColors.themeColor,
          child: Text(
            'Login',
            style: TextStyle(color: AppColors.themeColor),
          ),
          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => LoginSignupSelectionScreeen(),
//              ),
//            );
          },
          borderSide: BorderSide(color: AppColors.themeColor),
        ),
      ),
    );
  }
}
