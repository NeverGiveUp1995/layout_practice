import 'package:flutter/material.dart';
import 'package:layout_practice/views/Login/login.dart';
import 'package:layout_practice/views/Chat/Chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weChat',
      theme: ThemeData(primaryColor: Colors.white),
      home: new Login(),
    );
  }
}
