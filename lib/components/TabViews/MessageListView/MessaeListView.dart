import 'package:flutter/material.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/Message.dart';
import 'package:layout_practice/views/Chat/Chat.dart';

class MessageListView extends StatelessWidget {
  List<Message> messageList = [];

  MessageListView({@required messageList}) {
    this.messageList = messageList;
  }

  _openChatPage(BuildContext context, String nickName) {
    print("正在跳转到与$nickName的聊天页面");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Chat(
                title: nickName,
              )),
    );
  }

  List<Widget> _renderMessageList(BuildContext context) {
    List<Widget> messages = [];
    for (int i = 0; i < this.messageList.length; i++) {
      Message item = this.messageList[i];
      messages.add(
        FlatButton(
          onPressed: () => _openChatPage(context, item.sender.nickName),
          child: Container(
              height: 60.00,
              padding: EdgeInsets.all(3),
              child: Row(
                children: <Widget>[
                  Header(
                      width: 50.00,
                      height: 50.00,
                      imgSrc: item.sender.headerImg),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          昵称，或者备注，消息时间
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                                昵称、备注
                              Text(
                                item.sender.remark != null
                                    ? item.sender.remark //备注优先显示
                                    : item.sender.nickName,
                                style: TextStyle(fontSize: 16),
                              ),
//                                消息时间
                              Text(
                                item.sendTime,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 12),
                              ),
                            ],
                          ),
//                          消息内容（预览）
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              item.messageContent,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    }
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: this._renderMessageList(context),
      ),
    ));
  }
}
