import 'package:flutter/material.dart';

//AppBarの形式

class WidgetUtils {
  static AppBar createAppbar(String title){
    return AppBar(
      backgroundColor: Colors.transparent,  //背景透明
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(title, style: TextStyle(color: Colors.black)),
    );
  }
}