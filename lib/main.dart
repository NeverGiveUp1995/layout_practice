import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/blocs/theme/theme_bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/views/Chat/Chat.dart';
import 'package:layout_practice/views/CustomTheme/CustomTheme.dart';
import 'package:layout_practice/views/Home/Home.dart';
import 'package:layout_practice/views/Login/login.dart';
import 'package:layout_practice/views/Register/Register.dart';
import 'package:layout_practice/views/settings/Settings.dart';
import 'package:layout_practice/views/settings/ThemePage/ThemePage.dart';

import 'blocs/group/group_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
          "/register": (context) => Register(),
          //主页
          '/home': (context) => Home(
                context: context,
              ),
          //设置页面
          '/settings': (context) => Settings(),
          //主题设置页面
          '/settings/theme': (context) => ThemePage(),
          //自定义主题页面
          '/settings/theme/custom_theme': (context) => CustomTheme(),
        },
      ),
    );
  }
}
