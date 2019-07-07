import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  final String src;
  logo({Key key, @required this.src}):super(key:key);


  @override
  Widget build(BuildContext context) {
    final src = this.src;
    return new Container(
      width: 100,
      height: 100,
      child: new Image.asset(
        src,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
