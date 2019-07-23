import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/views/Home/Home.dart';
import 'package:layout_practice/views/Login/login.dart';
import 'package:layout_practice/views/settings/MyTheme/MyTheme.dart';
import 'package:layout_practice/views/settings/Settings.dart';

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
          '/home': (context) => Home(),
          '/settings': (context) => Settings(),
          '/settings/theme': (context) => MyTheme(),
        },
      ),
    );
  }
}
