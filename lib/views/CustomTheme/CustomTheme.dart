/**
    自定义主题页
 */
import 'package:flutter/material.dart';

class CustomTheme extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义主题"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
