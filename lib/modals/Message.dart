import 'package:flutter/material.dart';
import 'package:layout_practice/modals/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';

class Message {
  User sender; //发送者
  User addressee; //收件人
  String messageContent; //信息内容
  String sendTime; //发送时间

  Message({@required sender, @required addressee, messageContent, sendTime}) {
    this.sender = sender;
    this.addressee = addressee;
    this.messageContent = messageContent;
    this.sendTime = sendTime;
  }
}
