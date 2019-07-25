/**
 * 设置页面
 */
import 'package:flutter/material.dart';
import 'package:layout_practice/utils/consts/SettingAll.dart';

class Settings extends StatelessWidget {
  List<Widget> _renderSettingType(BuildContext context) {
    List<SettingType> settingList = SettingAll.getSettingList();
    List<Widget> settingTypeWidgets = List();
    if (settingList != null && settingList.length > 0) {
      settingList.forEach((item) {
        settingTypeWidgets.add(
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 25,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    item.typeName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                ),
                Column(
                  children: _renderSettingItems(context, item.settingItems),
                ),
              ],
            ),
          ),
        );
      });
    }
    print(settingTypeWidgets);
    return settingTypeWidgets;
  }

  List<Widget> _renderSettingItems(
      BuildContext context, List<SettingItem> settingItems) {
    List<Widget> settingItemsWidget = List();
    settingItems.forEach((item) {
      if (settingItems != null && settingItems.length > 0) {
        settingItemsWidget.add(
          Container(
            margin: EdgeInsets.only(top: 4),
            child: RaisedButton(
              color: Colors.white,
              elevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.settingName,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black38,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, item.routeName);
              },
            ),
          ),
        );
      }
    });
    return settingItemsWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "设置",
          style: TextStyle(fontSize: 16, fontWeight: null),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: _renderSettingType(context),
        ),
      ),
    );
  }
}
