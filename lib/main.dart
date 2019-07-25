import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/views/CustomTheme/CustomTheme.dart';
import 'package:layout_practice/views/Home/Home.dart';
import 'package:layout_practice/views/Login/login.dart';
import 'package:layout_practice/views/settings/Settings.dart';
import 'package:layout_practice/views/settings/ThemePage/ThemePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      builder: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'weTalk',
        theme: ThemeData(primaryColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          //主页
          '/home': (context) => Home(),
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
