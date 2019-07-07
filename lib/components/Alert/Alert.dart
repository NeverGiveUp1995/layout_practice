import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: new Container(
          color: Color.fromRGBO(50, 50, 50, 0.8),
          width: 200,
          height: 150,
          padding: new EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Text(
            "我是提示文字!！",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
