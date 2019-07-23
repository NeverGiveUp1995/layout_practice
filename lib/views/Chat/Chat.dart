import 'package:flutter/material.dart';
import 'package:layout_practice/utils/request.dart';

class Chat extends StatefulWidget {
  @required
  String title; //当前正在聊天的对象名称（好友备注/名称,群名称）

  Chat({title}) {
    this.title = title;
  }

  @override
  ChatState createState() => ChatState(this.title);
}

class ChatState extends State<Chat> {
  @required
  String _title;

  ChatState(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        //设置阴影辐射范围
        title: Text(
          this._title,
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromARGB(1, 220, 220, 220),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(5.00)),
            ),
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              constraints: BoxConstraints(maxHeight: 150, minHeight: 38),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextField(
                              maxLines: null,
                              //设置光标颜色
                              cursorColor: Color.fromRGBO(150, 150, 150, 0),
                              //设置光标宽度
                              cursorWidth: 1.5,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(8, 10, 8, 10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // 【输入框、发送按钮】
                  Container(
                    width: 68,
                    height: 38,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                    ),
                    child: FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        print("发送消息");
//                        NetServer.getIPAddress();
                      },
                      child: Text(
                        '发送',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
