import 'dart:core';

/**
 * 设置项类
 */
class SettingAll {
  static List<SettingType> getSettingList() {
    List<SettingType> list = List(); //所有的设置项
    List<SettingItem> aboutUsSettingType = List(); //关于我们设置
    SettingType individualizationSettingType = SettingType(
      '个性化',
      List<SettingItem>()
        ..add(
          SettingItem(settingName: "主题", routeName: '/settings/theme'),
        )
        ..add(
          SettingItem(routeName: '/settings/font', settingName: "字体"),
        ),
    );

    SettingType versionSettingType = SettingType(
      '版本信息',
      List<SettingItem>()
        ..add(
            SettingItem(settingName: '关于我们', routeName: '/settings/about_us')),
    );
    list..add(individualizationSettingType)..add(versionSettingType);
    return list;
  }
}

class SettingType {
  String typeName = '';
  List<SettingItem> settingItems = List();

  SettingType(this.typeName, this.settingItems);

  setSettingItems(List<SettingItem> settingItems) {
    this.settingItems = settingItems;
  }
}

class SettingItem {
  String routeName;
  String settingName;

  SettingItem({this.routeName, this.settingName});

  @override
  String toString() {
    return '{"routeName":"$routeName","settingName":"$settingName"}';
  }
}
