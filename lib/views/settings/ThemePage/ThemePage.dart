import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myTheme;
import 'package:layout_practice/theme/ThemeData.dart';

class ThemePage extends StatelessWidget {
  ThemeBloc _themeBloc;

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _currentState) {
        print(
            "_themeBloc====>${_themeBloc.currentState.theme}================${_currentState.theme}");
        return Scaffold(
          appBar: AppBar(
            leading: BackBtn(),
            title: Text(
              "主题设置",
              style: TextStyle(
                fontSize: 16,
                color: _currentState.theme != null
                    ? _currentState.theme.titleBarTextColor
                    : null,
              ),
            ),
            backgroundColor: _currentState.theme != null
                ? _currentState.theme.mainColor
                : Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            height: double.infinity,
            color: _currentState.theme != null
                ? _currentState.theme.bodyColor
                : Colors.white,
            child: RefreshIndicator(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        //系统预设主题模块
                        _ThemeTypeArea(
                          themeBloc: _themeBloc,
                          themeTypeName: '系统预设主题',
                          themes: AllThemes().sysDefaultThemes,
                        ),
                        //用户下载的主题模块
                        _ThemeTypeArea(
                          themeBloc: _themeBloc,
                          themeTypeName: '已下载主题',
                          themes: AllThemes().userDownloadThemes,
                          allowAdd: true,
                          callback: () {
                            print("进入商城页面，准备下载主题,功能待实现");
                          },
                        ),
                        //用户自定义主题模块
                        _ThemeTypeArea(
                          themeBloc: _themeBloc,
                          themeTypeName: '自定义主题',
                          themes: AllThemes().userDownloadThemes,
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
          ),
        );
      },
    );
  }
}

class _ThemeTypeArea extends StatelessWidget {
  ThemeBloc _themeBloc;
  String _themeTypeName;
  List<myTheme.Theme> _themes; //需要渲染的数据
  bool _allowAdd = false;
  Function _callback;

  _ThemeTypeArea({
    @required themeBloc,
    @required themeTypeName,
    @required themes,
    allowAdd,
    callback,
  }) {
    this._themeBloc = themeBloc;
    this._themeTypeName = themeTypeName;
    this._themes = themes;
    this._allowAdd = allowAdd == null ? false : true;
    this._callback =
        allowAdd == null ? () {} : callback == null ? () {} : callback;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      color: _themeBloc.currentState.theme != null
          ? _themeBloc.currentState.theme.textColor
          : Colors.black54,
      fontSize: 16,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: _themeBloc.currentState.theme != null
            ? _themeBloc.currentState.theme.bodyColor
            : Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Text(
            _themeTypeName,
            textAlign: TextAlign.center,
            style: _textStyle,
          ),
          _ThmeItems(
            themeBloc: _themeBloc,
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
  ThemeBloc _themeBloc;
  List<myTheme.Theme> _themes; //需要渲染的主题数据
  bool _allowAdd; //是否在最后渲染增加操作
  Function _callback; //点击增加按钮的时候，对应的回调函数

  _ThmeItems({@required themes, @required themeBloc, allowAdd, callback}) {
    this._themeBloc = themeBloc;
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
      _themes.forEach((theme) => {
            _themeWidgets.add(Container(
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
                          spreadRadius: 5,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        width: _width,
                        height: _height,
                        child: FlatButton(
                          onPressed: () {
                            _themeBloc.dispatch(ToggleTheme(
                              theme: theme,
                            ));
                          },
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    theme.themeName,
                    style: TextStyle(
                      color: _themeBloc.currentState.theme != null
                          ? _themeBloc.currentState.theme.textColor
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ))
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
                      color: _themeBloc.currentState.theme != null
                          ? _themeBloc.currentState.theme.shadowColor
                          : Colors.black12,
                      blurRadius: 25,
                      spreadRadius: 5,
                    )
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
              Text(
                "增加",
                style: TextStyle(
                  color: _themeBloc.currentState.theme != null
                      ? _themeBloc.currentState.theme.textColor
                      : Colors.black12,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _currentState) {
        return Wrap(
          children: _themeWidgets,
        );
      },
    );
  }
}
