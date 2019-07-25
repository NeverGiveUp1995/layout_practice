import 'package:flutter/material.dart';

/**
 * 主题类
 */
abstract class Theme {
  String themeId; //主题id
  String themeName; //主题名称
  Color mainColor; //主色调
  Color textColor; //文本字体颜色
  Color auxiliaryColor; //辅助色
  Color tipModalBgColor; //提示弹框背景色
  Color tipModalTextColor; //提示弹框的文字颜色
  Color textFieldCursorColor; //文本框光标的颜色
}

///天空蓝
class SkyBlue implements Theme {
  String themeId = '0';
  String themeName = '天空蓝';
  Color mainColor = Colors.blue; //主色调
  Color textColor = Colors.black38; //文本字体颜色
  Color auxiliaryColor = Colors.redAccent; //辅助色
  Color tipModalBgColor = Colors.black54; //提示弹框背景色
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色
}

///雅黑
class Yahei implements Theme {
  String themeId = '1';
  String themeName = '雅黑';
  Color auxiliaryColor = Colors.black38;
  Color mainColor = Color(0xff373e48);
  Color textColor = Color(0xffeeeeee);
  Color tipModalBgColor = Color(0x88888888);
  Color tipModalTextColor = Colors.white;
  Color textFieldCursorColor = Color(0xffeeeeee);
}

///简洁白
class SimpleWhite implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

///简洁白
class SimpleWhite0 implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

///简洁白
class SimpleWhite1 implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

///简洁白
class SimpleWhite2 implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

///简洁白
class SimpleWhite3 implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

///简洁白

class SimpleWhite4 implements Theme {
  String themeId = '2';
  String themeName = '简洁白';
  Color auxiliaryColor = Color.fromARGB(1, 223, 235, 240); //辅助色，淡灰色
  Color mainColor = Colors.white;
  Color textColor = Colors.black38;
  Color tipModalBgColor = Colors.black54; //提示弹框背景色;
  Color tipModalTextColor = Colors.black12; //提示弹框的文字颜色;
  Color textFieldCursorColor = Color(0xff6695ff); //文本框光标的颜色;
}

class AllThemes {
  List<Theme> _sysDefaultThemes = List();
  List<Theme> _userDownloadThemes = List();

  get sysDefaultThemes => _sysDefaultThemes;

  get userDownloadThemes => _userDownloadThemes;

  AllThemes() {
    _sysDefaultThemes..add(SkyBlue())..add(Yahei())..add(SimpleWhite());
//    用户下载的数据，要从本地获取，（暂无）当用户下载了之后，需要将下载的所有主题，写入一个文件，存放在本地，然后，在此处自动读取该文件，暂时还未实现
  }
}
