import 'package:flutter/material.dart';

class AppColors {

//  static const Color bubblegumPinkColor = Color(0xffE9738D);
  static const Color greyColor = AppColors.themeGreyColor;
  static const Color themeColor = Color(0Xff234C5A);//Color(0xffe34234 )
  //static const Color themeLightColor = Color(0XffFE642E);//
  static const Color themeGreyColor = Color(0XffD2D3D5);

  static const Color nebulosityBlackColor = Color(0xff1C1C1B);
  //static const Color greenColor = Colors.green;
  //static const Color lightGreenColor = Color(0xffB2F595);

  static const Color lightPinkColor = Color(0xffFADADD);
  static const Color darkyelloColor = Color(0xffc59100);
  static const Color whiteColor = Colors.white;

  static const Color redColor1 = Color(0xffff3a5a);
  static const Color redColor2 = Color(0xfffe494d);

  static List<Color> colorList = [];

  static initializeColor(){
    colorList.add(Color(0xffEE8474));
    colorList.add(Color(0xff7DB7E6));
    colorList.add(Color(0xffDCBD52));
    colorList.add(Color(0xff705AF1));
    colorList.add(Color(0xffBCCA9A));
    colorList.add(Color(0xffF13030));
    colorList.add(Color(0xff4EB5E6));
    colorList.add(Color(0xffEFD320));
    colorList.add(Color(0xff42F48E));
    colorList.add(Color(0xffED1A21));
    colorList.add(Color(0xffE390D3));
    colorList.add(Color(0xffF5F4B2));
    colorList.add(Color(0xff259234));
    colorList.add(Color(0xff250BE8));
    colorList.add(Color(0xff868971));
    colorList.add(Color(0xffECAE52));
    colorList.add(Color(0xff7F2AA0));
    colorList.add(Color(0xff665789));
    colorList.add(Color(0xff93E065));
    colorList.add(Color(0xff8EF0F3));
  }
  static Color getColor(int index){
    return colorList[index];
  }
}

