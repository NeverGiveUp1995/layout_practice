import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/components/Drawers/Person/PersonDrawer.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/components/Tab/Tab.dart';
import 'package:layout_practice/components/TabViews/ContactsTabView/ContactsTabView.dart';
import 'package:layout_practice/components/TabViews/MessageListView/MessaeListView.dart';
import 'package:layout_practice/config/my_flutter_app_icons.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';

import 'package:layout_practice/utils/webSocket/MessageUtils.dart';

class Home extends StatefulWidget {
  GlobalKey _key = GlobalKey();
  BuildContext context;

  Home({@required this.context});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String _pageTitle;
  Color backgroundColor = Color.fromARGB(1, 223, 235, 240); //主页背景色
  Color fontColor = Colors.black54; //字体颜色
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;
  MessageBloc _messageBloc;
  WebSocketBloc _webSocketBloc;
  List<String> titles = ['消息', '联系人', '互动', '短视频'];

  @override
  void initState() {
    super.initState();
    setState(() {
      this._pageTitle = titles[0];
    });
  }

  void _changeTitle(int tabIndex) {
    this.setState(() => {this._pageTitle = titles[tabIndex]});
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
//    创建websocket连接
    MessageUtils.connect(_authBloc.currentState.user.account, context);
    if (_authBloc.currentState.user != null &&
        _authBloc.currentState.user.account != null &&
        _messageBloc.currentState.messageList == null) {
      _messageBloc
          .dispatch(GetMessageList(_authBloc.currentState.user.account));
    }
    if (_themeBloc.currentState.theme != null &&
        _themeBloc.currentState.theme.textColor.value != fontColor.value) {
      this.setState(() {
        fontColor = Color(_themeBloc.currentState.theme.textColor.value);
      });
    }
    if (_themeBloc.currentState.theme != null &&
        _themeBloc.currentState.theme.mainColor.value !=
            backgroundColor.value) {
      this.setState(() {
        backgroundColor = Color(_themeBloc.currentState.theme.mainColor.value);
      });
    }
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState authState) {
        return BlocBuilder(
          bloc: _themeBloc,
          builder: (BuildContext context, ThemeState themeState) {
            return BlocBuilder(
              bloc: _messageBloc,
              builder:
                  (BuildContext messagecontext, MessageState messageState) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
//        设置阴影辐射范围
                    elevation: 0,
                    backgroundColor: _themeBloc.currentState.theme != null
                        ? _themeBloc.currentState.theme.titleBarBGColor
                        : Colors.white,
                    leading: Header(
                      width: 30.0,
                      height: 30.0,
                      borderColor: Color(0x00000000),
                      borderWidth: 0.0,
                      imgSrc: _authBloc.currentState.user != null
                          ? _authBloc.currentState.user.headerImg
                          : null,
                      isMan: true,
                    ),
                    title: Text(
                      _pageTitle, //页面标题
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: _themeBloc.currentState.theme != null &&
                                _themeBloc
                                        .currentState.theme.titleBarTextColor !=
                                    null
                            ? _themeBloc.currentState.theme.titleBarTextColor
                            : fontColor,
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: _themeBloc.currentState.theme != null &&
                              _themeBloc.currentState.theme.textColor != null
                          ? _themeBloc.currentState.theme.textColor
                          : fontColor,
                    ),
                    actions: <Widget>[
//          隐藏起来的菜单项
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.menu,
                          color: _themeBloc.currentState.theme != null &&
                                  _themeBloc.currentState.theme
                                          .titleBarTextColor !=
                                      null
                              ? _themeBloc.currentState.theme.titleBarTextColor
                              : fontColor,
                        ),
                        offset: Offset(0, 50),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuItem<String>>[
                          PopupMenuItem(
                            value: 'A',
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.search,
                                      color: _themeBloc.currentState.theme !=
                                                  null &&
                                              _themeBloc.currentState.theme
                                                      .textColor !=
                                                  null
                                          ? _themeBloc
                                              .currentState.theme.textColor
                                          : null,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    '查找好友',
                                    style: TextStyle(
                                      color: _themeBloc.currentState.theme !=
                                                  null &&
                                              _themeBloc.currentState.theme
                                                      .textColor !=
                                                  null
                                          ? _themeBloc
                                              .currentState.theme.textColor
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'B',
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.supervisor_account,
                                    color:
                                        _themeBloc.currentState.theme != null &&
                                                _themeBloc.currentState.theme
                                                        .textColor !=
                                                    null
                                            ? _themeBloc
                                                .currentState.theme.textColor
                                            : null,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  '创建群聊',
                                  style: TextStyle(
                                    color:
                                        _themeBloc.currentState.theme != null &&
                                                _themeBloc.currentState.theme
                                                        .textColor !=
                                                    null
                                            ? _themeBloc
                                                .currentState.theme.textColor
                                            : null,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        onSelected: (String action) {
                          switch (action) {
                            case 'A':
                              print("选择了A");
                              break;
                            case 'B':
                              print("选择了B");
                              break;
                          }
                        },
                      )
                    ],
                  ),
                  body: Center(
                    child: Container(
                      color: _themeBloc.currentState.theme != null &&
                              _themeBloc.currentState.theme.mainColor != null
                          ? _themeBloc.currentState.theme.mainColor
                          : backgroundColor,
                      child: TabView(
                        onTabChange: this._changeTitle,
                        titles: titles,
                        tabViews: [
                          MessageListView(
                            messageList:
                                _messageBloc.currentState.messageList != null
                                    ? _messageBloc.currentState.messageList
                                    : null,
                            themeBloc: _themeBloc,
                          ),
                          ContactsTabView(),
                          Container(
                            child: Text("暂未开放"),
                          ),
                          Container(
                            child: Text("暂未开放"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  drawer: Drawer(
                    child: PersonDrawer(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
