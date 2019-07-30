import 'dart:convert';

import 'package:flutter/material.dart';

/**
 * 主题类
 */
class Theme {
  String themeId; //主题id
  String themeName; //主题名称
  Color mainColor; //主色调
  Color titleBarBGColor; //标题栏色调
  Color titleBarTextColor; //标题栏色调
  Color bodyColor; //内容区颜色
  Color bottomColor; //底部操作拦颜色
  Color personDrawerBgColor; //用户抽屉，背景蒙层色
  Color contrastColor; //反差色（与主色调相反）
  Color shadowColor; //阴影颜色
  Color textColor; //文本字体颜色
  Color auxiliaryColor; //辅助色
  Color tipModalBgColor; //提示弹框背景色
  Color tipModalTextColor; //提示弹框的文字颜色
  Color textFieldCursorColor; //文本框光标的颜色
  Color selectedColor; //选中的颜色
  Theme({
    @required themeId,
    @required themeName,
    @required mainColor,
    @required titleBarBGColor, //标题栏色调
    @required titleBarTextColor, //标题栏文字色调
    @required bodyColor, //内容区颜色
    @required bottomColor, //底部操作拦颜色
    @required personDrawerBgColor, //底部操作拦颜色
    @required contrastColor,
    @required shadowColor,
    @required textColor,
    @required auxiliaryColor,
    @required tipModalBgColor,
    @required tipModalTextColor,
    @required textFieldCursorColor,
    @required selectedColor,
  }) {
    this.themeId = themeId;
    this.themeName = themeName;
    if (mainColor is int) {
      this.mainColor = Color(mainColor);
    } else if (mainColor is Color) {
      this.mainColor = mainColor;
    }
    if (contrastColor is int) {
      this.contrastColor = Color(contrastColor);
    } else if (contrastColor is Color) {
      this.contrastColor = contrastColor;
    }
    if (titleBarBGColor is int) {
      this.titleBarBGColor = Color(titleBarBGColor);
    } else if (titleBarBGColor is Color) {
      this.titleBarBGColor = titleBarBGColor;
    }
    if (titleBarTextColor is int) {
      this.titleBarTextColor = Color(titleBarTextColor);
    } else if (titleBarTextColor is Color) {
      this.titleBarTextColor = titleBarTextColor;
    }
    if (bodyColor is int) {
      this.bodyColor = Color(bodyColor);
    } else if (bodyColor is Color) {
      this.bodyColor = bodyColor;
    }
    if (bottomColor is int) {
      this.bottomColor = Color(bottomColor);
    } else if (bottomColor is Color) {
      this.bottomColor = bottomColor;
    }
    if (personDrawerBgColor is int) {
      this.bottomColor = Color(personDrawerBgColor);
    } else if (personDrawerBgColor is Color) {
      this.personDrawerBgColor = personDrawerBgColor;
    }

    if (shadowColor is int) {
      this.shadowColor = Color(shadowColor);
    } else if (shadowColor is Color) {
      this.shadowColor = shadowColor;
    }
    if (textColor is int) {
      this.textColor = Color(textColor);
    } else if (textColor is Color) {
      this.textColor = textColor;
    }
    if (auxiliaryColor is int) {
      this.auxiliaryColor = Color(auxiliaryColor);
    } else if (auxiliaryColor is Color) {
      this.auxiliaryColor = auxiliaryColor;
    }
    if (tipModalBgColor is int) {
      this.tipModalBgColor = Color(tipModalBgColor);
    } else if (tipModalBgColor is Color) {
      this.tipModalBgColor = tipModalBgColor;
    }
    if (tipModalTextColor is int) {
      this.tipModalTextColor = Color(tipModalTextColor);
    } else if (tipModalTextColor is Color) {
      this.tipModalTextColor = tipModalTextColor;
    }
    if (textFieldCursorColor is int) {
      this.textFieldCursorColor = Color(textFieldCursorColor);
    } else if (textFieldCursorColor is Color) {
      this.textFieldCursorColor = textFieldCursorColor;
    }
    if (selectedColor is int) {
      this.selectedColor = Color(selectedColor);
    } else if (selectedColor is Color) {
      this.selectedColor = selectedColor;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['themeId'] = this.themeId;
    data['themeName'] = this.themeName;
    data['titleBarBGColor'] = this.titleBarBGColor.value.toString();
    data['titleBarTextColor'] = this.titleBarTextColor.value.toString();
    data['bodyColor'] = this.bodyColor.value.toString();
    data['bottomColor'] = this.bottomColor.value.toString();
    data['personDrawerBgColor'] = this.personDrawerBgColor.value.toString();
    data['mainColor'] = this.mainColor.value.toString();
    data['contrastColor'] = this.contrastColor.value.toString();
    data['shadowColor'] = this.shadowColor.value.toString();
    data['textColor'] = this.textColor.value.toString();
    data['auxiliaryColor'] = this.auxiliaryColor.value.toString();
    data['tipModalBgColor'] = this.tipModalBgColor.value.toString();
    data['tipModalTextColor'] = this.tipModalTextColor.value.toString();
    data['textFieldCursorColor'] = this.textFieldCursorColor.value.toString();
    data['selectedColor'] = this.selectedColor.value.toString();
    return data;
  }

  @override
  String toString() {
    var jsonStr = toJson();
    return json.encode(jsonStr);
  }
}
