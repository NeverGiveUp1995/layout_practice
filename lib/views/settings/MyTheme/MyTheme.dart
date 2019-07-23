import 'package:flutter/material.dart';

class MyTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题设置"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          width: 80,
          height: 80 * 0.618,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(0xffdddddd), offset: Offset(0, 5)),
            ],
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Colors.black12, width: 1),
          ),
          child: UnconstrainedBox(
            child: Column(
              children: <Widget>[
                Text("简洁白"),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
