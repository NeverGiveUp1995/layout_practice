import 'package:flutter/material.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myTheme;

class AllThemes {
  List<myTheme.Theme> _sysDefaultThemes = List();
  List<myTheme.Theme> _userDownloadThemes = List();
  List<myTheme.Theme> _userCustomThemes = List();

  get sysDefaultThemes => _sysDefaultThemes;

  get userDownloadThemes => _userDownloadThemes;

  get userCustomThemes => _userCustomThemes;

  AllThemes() {
    myTheme.Theme simpleWhite = myTheme.Theme(
      themeId: '0',
      themeName: '简洁白',
      contrastColor: Colors.black87,
      shadowColor: Colors.black12,
      auxiliaryColor: Color.fromARGB(1, 223, 235, 240),
      mainColor: Colors.white,
      titleBarBGColor: Colors.white,
      titleBarTextColor: Colors.black54,
      bodyColor: Color(0x000e0e0e),
      bottomColor: Colors.white,
      personDrawerBgColor: Color(0xaa898989),
      textColor: Colors.black38,
      tipModalBgColor: Colors.black54,
      tipModalTextColor: Colors.black12,
      textFieldCursorColor: Color(0xff00a4ff),
      selectedColor: Color(0xff00a4ff),
    );
    myTheme.Theme skyBlue = myTheme.Theme(
      themeId: '1',
      themeName: '天空蓝',
      mainColor: Color(0xff00a4ff),
      contrastColor: Color(0x99ffffff),
      titleBarBGColor: Colors.white,
      titleBarTextColor: Colors.white,
      bodyColor: Color(0xffefefef),
      bottomColor: Colors.white,
      personDrawerBgColor: Color(0xaa898989),
      shadowColor: Color(0x44ffffff),
      textColor: Color(0xff696969),
      auxiliaryColor: Color(0x55eeeeee),
      tipModalBgColor: Colors.black54,
      tipModalTextColor: Colors.black12,
      textFieldCursorColor: Color(0xff00a4ff),
      //文本框光标的颜色
      selectedColor: Color(0xff00a4ff),
    );
    myTheme.Theme yahei = myTheme.Theme(
      themeId: '2',
      themeName: '雅黑',
      contrastColor: Color(0x99ffffff),
      shadowColor: Color(0x66000000),
      auxiliaryColor: Colors.black12,
      mainColor: Color(0xff373e48),
      titleBarBGColor: Color(0xff373e48),
      titleBarTextColor: Color(0xffcdcdcd),
      bodyColor: Color(0xff373e48),
      bottomColor: Color(0xff373e48),
      personDrawerBgColor: Color(0xee373e48),
      textColor: Color(0xffeeeeee),
      tipModalBgColor: Color(0x88888888),
      tipModalTextColor: Colors.white,
      textFieldCursorColor: Color(0xffeeeeee),
      selectedColor: Color(0xffcecece),
    );

    _sysDefaultThemes..add(simpleWhite)..add(skyBlue)..add(yahei);
//    用户下载的数据，要从本地获取，（暂无）当用户下载了之后，需要将下载的所有主题，写入一个文件，存放在本地，然后，在此处自动读取该文件，暂时还未实现
  }
}
