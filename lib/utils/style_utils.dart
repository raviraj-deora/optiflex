import 'package:flutter/material.dart';

import 'app_colors.dart';

const double homeCirlceImgWidth = 100;
const double homeCirlceImgHeight = 100;

const double drawerImgWidth = 25;
const double drawerImgHeignt = 25;

BoxDecoration bgGradiant = BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [Color(0xff101A23), AppColors.themeColor], // whitish to gray
// repeats the gradient over the canvas
),
);

Widget CustomCircularProgressIndicator(Color color)
{
  return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(color));
}
Widget NoDataWidget(String txt){
  return Center(child: Text(txt,style: TextStyle(color: AppColors.themeColor),));
}