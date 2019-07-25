import 'package:flutter/material.dart';
import 'package:layout_practice/theme/Theme.dart' as myTheme;
import 'package:layout_practice/theme/Theme.dart';

class ThemePage extends StatelessWidget {
  _renderCustomTheme() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("主题设置"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: RefreshIndicator(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      //系统预设主题模块
                      _ThemeTypeArea(
                        themeTypeName: '系统预设主题',
                        themes: myTheme.AllThemes().sysDefaultThemes,
                      ),
                      //用户下载的主题模块
                      _ThemeTypeArea(
                        themeTypeName: '已下载主题',
                        themes: myTheme.AllThemes().userDownloadThemes,
                        allowAdd: true,
                        callback: () {
                          print("进入商城页面，准备下载主题,功能待实现");
                        },
                      ),
                      //用户自定义主题模块
                      _ThemeTypeArea(
                        themeTypeName: '自定义主题',
                        themes: myTheme.AllThemes().userDownloadThemes,
                        allowAdd: true,
                        callback: () {
                          Navigator.pushNamed(
                              context, '/settings/theme/custom_theme');
                          print("进入自定义主题设置页面,功能待实现");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              onRefresh: () {
                print("正在刷新。。");
              }),
        ));
  }
}

class _ThemeTypeArea extends StatelessWidget {
  TextStyle _textStyle = TextStyle(color: Colors.black54, fontSize: 18);
  String _themeTypeName;

  List<myTheme.Theme> _themes; //需要渲染的数据
  bool _allowAdd = false;
  Function _callback;

  _ThemeTypeArea(
      {@required themeTypeName, @required themes, allowAdd, callback}) {
    this._themeTypeName = themeTypeName;
    this._themes = themes;
    this._allowAdd = allowAdd == null ? false : true;
    this._callback =
        allowAdd == null ? () {} : callback == null ? () {} : callback;
  }

  @override
  Widget build(BuildContext context) {
    print("传入之前的allowAdd${_allowAdd}");
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Text(
            _themeTypeName,
            textAlign: TextAlign.center,
            style: _textStyle,
          ),
          _ThmeItems(
            themes: _themes,
            allowAdd: _allowAdd,
            callback: _callback,
          )
        ],
      ),
    );
    ;
  }
}

class _ThmeItems extends StatelessWidget {
  List<myTheme.Theme> _themes; //需要渲染的数据
  bool _allowAdd; //是否在最后渲染增加操作
  Function _callback; //点击增加按钮的时候，对应的回调函数

  _ThmeItems({@required themes, allowAdd, callback}) {
    this._themes = themes;
    this._allowAdd = allowAdd == null ? false : allowAdd;
    this._callback =
        allowAdd == null ? () {} : callback == null ? () {} : callback;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _themeWidgets = List();
    double _width = 50.0;
    double _height = 50.0;
    if (_themes != null && _themes.length > 0) {
      _themes.forEach((theme) {
        _themeWidgets.add(
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: theme.mainColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25,
                          spreadRadius: 5)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Text(theme.themeName),
              ],
            ),
          ),
        );
      });
    } else {
      if (_allowAdd == false) {
        _themeWidgets.add(
          Container(
            padding: EdgeInsets.all(25),
            child: Container(
              width: 45,
              child: Image.asset('images/empty.png'),
            ),
          ),
        );
      }
    }
    //如果传入的参数为允许进行增加主题的操作，在最后添加增加操作的按钮
    if (_allowAdd == true) {
      _themeWidgets.add(
        Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 25, spreadRadius: 5)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      elevation: 0,
                      child: Icon(
                        Icons.add,
                        color: Colors.black26,
                      ),
                      onPressed: _callback,
                    ),
                  ),
                ),
              ),
              Text("增加"),
            ],
          ),
        ),
      );
    }
    return Wrap(
      children: _themeWidgets,
    );
  }
}
