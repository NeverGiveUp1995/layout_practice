import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';

class PersonDrawer extends StatelessWidget {
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _authBloc,
          listener: (context, state) {},
        ),
        BlocListener(
          bloc: _themeBloc,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
          body: Stack(children: <Widget>[
            //背景图片
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563789415399&di=646c60c73836159b5dee307548b47974&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201511%2F14%2F20151114184017_Y582J.thumb.700_0.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            //蒙层，使用毛玻璃效果的
            Container(),
            Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      //基本信息
                      Container(
                        height: 180,
                      ),
                      //操作
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _themeBloc.currentState.theme != null &&
                                    _themeBloc.currentState.theme
                                            .personDrawerBgColor !=
                                        null
                                ? _themeBloc
                                    .currentState.theme.personDrawerBgColor
                                : null,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(),
                              Align(
                                alignment: FractionalOffset(0.5, -0.15),
                                //UnconstrainedBox:该组件会解除子元素的限制约束，通常情况下，Column组件，会撑尽可能的达到最大，但是此处仅仅需要Column的垂直布局，并且需要它由内容撑开
                                child: UnconstrainedBox(
                                  child: Column(
                                    children: <Widget>[
                                      Header(
                                        width: 120.0,
                                        height: 120.0,
                                        isMan: true,
                                        borderColor: Color(0x00000000),
                                        borderWidth: 0.0,
                                        imgSrc:
                                            _authBloc.currentState.user != null
                                                ? _authBloc
                                                    .currentState.user.headerImg
                                                : null,
                                      ),
                                      Text(
                                        _authBloc.currentState.user != null
                                            ? _authBloc
                                                .currentState.user.nickName
                                            : '未知用户名',
                                        style: TextStyle(
                                          color: _themeBloc
                                                          .currentState.theme !=
                                                      null &&
                                                  _themeBloc.currentState.theme
                                                          .titleBarTextColor !=
                                                      null
                                              ? _themeBloc.currentState.theme
                                                  .titleBarTextColor
                                              : null,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          bottomSheet: Container(
            color: _themeBloc.currentState.theme != null &&
                    _themeBloc.currentState.theme.mainColor != null
                ? _themeBloc.currentState.theme.mainColor
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  color: Colors.black38,
                  iconSize: 22,
                  tooltip: "设置",
                  icon: Icon(
                    Icons.settings,
                    color: _themeBloc.currentState.theme != null &&
                            _themeBloc.currentState.theme.titleBarTextColor !=
                                null
                        ? _themeBloc.currentState.theme.titleBarTextColor
                        : null,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
          )),
    );
  }
}
