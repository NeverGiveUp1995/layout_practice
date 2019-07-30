/**
 * 设置页面
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/utils/consts/SettingAll.dart';

class Settings extends StatelessWidget {
  ThemeBloc _themeBloc;

  List<Widget> _renderSettingType(BuildContext context, ThemeBloc _themeBloc) {
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
                      color: _themeBloc.currentState.theme != null &&
                              _themeBloc.currentState.theme.textColor != null
                          ? _themeBloc.currentState.theme.textColor
                          : null,
                    ),
                  ),
                ),
                Column(
                  children: _renderSettingItems(
                      context, item.settingItems, _themeBloc),
                ),
              ],
            ),
          ),
        );
      });
    }
    return settingTypeWidgets;
  }

  List<Widget> _renderSettingItems(BuildContext context,
      List<SettingItem> settingItems, ThemeBloc _themeBloc) {
    List<Widget> settingItemsWidget = List();
    settingItems.forEach((item) {
      if (settingItems != null && settingItems.length > 0) {
        settingItemsWidget.add(
          Container(
            margin: EdgeInsets.only(top: 4),
            child: RaisedButton(
              color: _themeBloc.currentState.theme != null &&
                      _themeBloc.currentState.theme.auxiliaryColor != null
                  ? _themeBloc.currentState.theme.auxiliaryColor
                  : null,
              elevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.settingName,
                    style: TextStyle(
                      fontSize: 16,
                      color: _themeBloc.currentState.theme != null &&
                              _themeBloc.currentState.theme.textColor != null
                          ? _themeBloc.currentState.theme.textColor
                          : null,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: _themeBloc.currentState.theme != null &&
                            _themeBloc.currentState.theme.textColor != null
                        ? _themeBloc.currentState.theme.textColor
                        : null,
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
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        centerTitle: true,
        backgroundColor: _themeBloc.currentState.theme != null &&
                _themeBloc.currentState.theme.mainColor != null
            ? _themeBloc.currentState.theme.mainColor
            : null,
        title: Text(
          "设置",
          style: TextStyle(
            color: _themeBloc.currentState.theme != null &&
                    _themeBloc.currentState.theme.titleBarTextColor != null
                ? _themeBloc.currentState.theme.titleBarTextColor
                : null,
            fontSize: 16,
            fontWeight: null,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: _themeBloc.currentState.theme != null &&
                _themeBloc.currentState.theme.bodyColor != null
            ? _themeBloc.currentState.theme.bodyColor
            : null,
        child: Column(
          children: _renderSettingType(context, _themeBloc),
        ),
      ),
    );
  }
}
