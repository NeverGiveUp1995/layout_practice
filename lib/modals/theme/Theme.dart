import 'dart:convert';

import 'package:flutter/material.dart';

/**
 * 主题类
 */
class Theme {
  String themeId; //主题id
  String themeName; //主题名称
  Color mainColor; //主色调
  Color contrastColor; //反差色（与主色调相反）
  Color titleBarBGColor; //标题栏背景色
  Color titleBarTextColor; //标题栏文本色
  Color bodyColor; //内容区背景色
  Color bottomColor; //底部操作拦颜色
  Color personDrawerBgColor; //用户抽屉，背景蒙层色
  Color shadowColor; //阴影颜色
  Color textColor; //文本字体颜色
  Color settingItemBgColor; //辅助色,(用于设置页面每个设置项背景色)
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
    @required settingItemBgColor,
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
      this.personDrawerBgColor = Color(personDrawerBgColor);
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
    if (settingItemBgColor is int) {
      this.settingItemBgColor = Color(settingItemBgColor);
    } else if (settingItemBgColor is Color) {
      this.settingItemBgColor = settingItemBgColor;
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
    data['themeId'] = this.themeId != null ? this.themeId.toString() : 'null';
    data['themeName'] =
        this.themeName != null ? this.themeName.toString() : 'null';
    data['titleBarBGColor'] =
        this.titleBarBGColor != null && this.titleBarBGColor.value != null
            ? this.titleBarBGColor.value.toString()
            : 'null';
    data['titleBarTextColor'] =
        this.titleBarTextColor != null && this.titleBarTextColor.value != null
            ? this.titleBarTextColor.value.toString()
            : 'null';
    data['bodyColor'] = this.bodyColor != null && this.bodyColor.value != null
        ? this.bodyColor.value.toString()
        : 'null';
    data['bottomColor'] =
        this.bottomColor != null && this.bottomColor.value != null
            ? this.bottomColor.value.toString()
            : 'null';
    data['personDrawerBgColor'] = this.personDrawerBgColor != null &&
            this.personDrawerBgColor.value != null
        ? this.personDrawerBgColor.value.toString()
        : 'null';
    data['mainColor'] = this.mainColor != null && this.mainColor.value != null
        ? this.mainColor.value.toString()
        : 'null';
    data['contrastColor'] =
        this.contrastColor != null && this.contrastColor.value != null
            ? this.contrastColor.value.toString()
            : 'null';
    data['shadowColor'] =
        this.shadowColor != null && this.shadowColor.value != null
            ? this.shadowColor.value.toString()
            : 'null';
    data['textColor'] = this.textColor != null && this.textColor.value != null
        ? this.textColor.value.toString()
        : 'null';
    data['settingItemBgColor'] =
        this.settingItemBgColor != null && this.settingItemBgColor.value != null
            ? this.settingItemBgColor.value.toString()
            : 'null';
    data['tipModalBgColor'] =
        this.tipModalBgColor != null && this.tipModalBgColor.value != null
            ? this.tipModalBgColor.value.toString()
            : 'null';
    data['tipModalTextColor'] =
        this.tipModalTextColor != null && this.tipModalTextColor.value != null
            ? this.tipModalTextColor.value.toString()
            : 'null';
    data['textFieldCursorColor'] = this.textFieldCursorColor != null &&
            this.textFieldCursorColor.value != null
        ? this.textFieldCursorColor.value.toString()
        : 'null';
    data['selectedColor'] =
        this.selectedColor != null && this.selectedColor.value != null
            ? this.selectedColor.value.toString()
            : 'null';
    return data;
  }

  @override
  String toString() {
    var jsonStr = toJson();
    return json.encode(jsonStr);
  }
}
