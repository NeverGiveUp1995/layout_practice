import 'package:flutter/material.dart';

/**
 * 主题类
 */
abstract class Theme {
  Color mainColor; //主色调
  Color textColor; //文本字体颜色
  Color auxiliaryColor; //辅助色
  Color tipModalBgColor; //提示弹框背景色
  Color tipModalTextColor; //提示弹框的文字颜色
  Color textFieldCursorColor; //文本框光标的颜色
}

///天空蓝
class SkyBlue implements Theme {
  Color mainColor = Colors.blue; //主色调
  Color textColor = Colors.black38; //文本字体颜色
  Color auxiliaryColor = Colors.redAccent; //辅助色
  Color tipModalBgColor = Colors.black54; //提示弹框背景色
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色
}

///雅黑
class Yahei implements Theme {
  Color auxiliaryColor = Colors.black38;
  Color mainColor = Color(0xff373e48);
  Color textColor = Color(0xffeeeeee);
  Color tipModalBgColor = Color(0x88888888);
  Color tipModalTextColor = Colors.white;
  Color textFieldCursorColor = Color(0xffeeeeee);
}

///简洁白
class SimpleWhite implements Theme {
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}
