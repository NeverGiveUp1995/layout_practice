import 'package:flutter/material.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';

class Message {
  int messageId; //消息id
  int conversationId; //对话id
  User sender; //发送者
  User receiver; //收件人
  String sendTime; //发送时间
  String content; //信息内容

  Message({
    this.messageId,
    this.conversationId,
    @required this.sender,
    @required this.receiver,
    this.sendTime,
    @required this.content,
  });

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    conversationId = json['conversationId'];
    sender = User.fromJson(json['sender']);
    receiver = User.fromJson(json['receiver']);
    sendTime = json['sendTime'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['conversationId'] = this.conversationId;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['sendTime'] = this.sendTime;
    data['content'] = this.content;
    return data;
  }
}
