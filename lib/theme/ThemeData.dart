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
      settingItemBgColor: Colors.white,
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
      titleBarBGColor: Color(0xff00a4ff),
      titleBarTextColor: Colors.white,
      bodyColor: Color(0x000e0e0e),
      bottomColor: Colors.white,
      personDrawerBgColor: Color(0xaa898989),
      shadowColor: Color(0x44dedede),
      textColor: Color(0xff696969),
      settingItemBgColor: Colors.white,
      tipModalBgColor: Colors.black54,
      tipModalTextColor: Colors.black12,
      textFieldCursorColor: Color(0xff00a4ff),
      //文本框光标的颜色
      selectedColor: Color(0xff00a4ff),
    );
    myTheme.Theme eleganceBlack = myTheme.Theme(
      themeId: '2',
      themeName: '雅黑',
      contrastColor: Color(0x99ffffff),
      shadowColor: Color(0x66000000),
      settingItemBgColor: Colors.black12,
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
    myTheme.Theme red = myTheme.Theme(
      themeId: "3",
      themeName: "艳红",
      mainColor: Colors.redAccent,
      titleBarBGColor: Colors.redAccent,
      titleBarTextColor: Colors.white,
      bodyColor: Color(0x000e0e0e),
      bottomColor: Colors.redAccent,
      personDrawerBgColor: Color(0xefffffff),
      contrastColor: Colors.white,
      shadowColor: Color(0x00dedede),
      textColor: Colors.black54,
      settingItemBgColor: Colors.white,
      tipModalBgColor: Color(0x22ef0000),
      tipModalTextColor: Colors.black54,
      textFieldCursorColor: Colors.redAccent,
      selectedColor: Colors.white,
    );
    _sysDefaultThemes
      ..add(simpleWhite)
      ..add(skyBlue)
      ..add(eleganceBlack)
      ..add(red);
//    用户下载的数据，要从本地获取，（暂无）当用户下载了之后，需要将下载的所有主题，写入一个文件，存放在本地，然后，在此处自动读取该文件，暂时还未实现
  }
}
