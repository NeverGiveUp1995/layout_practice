//第三方引入
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //引入通知插件库

//自定义页面（路由组件）组件引入
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/blocs/theme/theme_bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/views/CustomTheme/CustomTheme.dart';
import 'package:layout_practice/views/Home/Home.dart';
import 'package:layout_practice/views/Login/login.dart';
import 'package:layout_practice/views/Register/Register.dart';
import 'package:layout_practice/views/settings/Settings.dart';
import 'package:layout_practice/views/settings/ThemePage/ThemePage.dart';

import 'blocs/group/group_bloc.dart';
import 'blocs/notice/notice_bloc.dart';
import 'components/NoticationFrame/NoticationFrame.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
//    _showNotification(1, "测试", "我是测试消息", '');
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider<AuthBloc>(
          builder: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<MessageBloc>(
          builder: (BuildContext context) => MessageBloc(),
        ),
        BlocProvider<WebSocketBloc>(
          builder: (BuildContext context) => WebSocketBloc(),
        ),
        BlocProvider<NoticeBloc>(
          builder: (BuildContext context) => NoticeBloc(),
        ),
        BlocProvider<GroupBloc>(
          builder: (BuildContext context) => GroupBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'weTalk',
        theme: ThemeData(primaryColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          "/register": (context) => NotificationFrame(child: Register()),
          //主页
          '/home': (context) => NotificationFrame(
                child: Home(
                  context: context,
                ),
              ),
          '/settings': (context) => NotificationFrame(
                child: Settings(),
              ),
          //设置页面
          //主题设置页面
          '/settings/theme': (context) => NotificationFrame(
                child: ThemePage(),
              ),
          //自定义主题页面
          '/settings/theme/custom_theme': (context) => NotificationFrame(
                child: CustomTheme(),
              ),
        },
      ),
    );
  }
}
