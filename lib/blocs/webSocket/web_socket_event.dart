import 'package:flutter/material.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WebSocketEvent {}

/**
 * 收到好友消息的操作
 */
class ReceivedMessageWithFriend extends WebSocketEvent {
  Message message;
  BuildContext context;

  ReceivedMessageWithFriend({
    @required this.message,
    @required this.context,
  });

  @override
  String toString() {
    return 'RECEIVEDMESSAGEWITHFRIEND';
  }
}

/**
 * 向好友发送消息的事件
 */
class SendMessageToFriend extends WebSocketEvent {
  Message message;
  BuildContext context;

  SendMessageToFriend({@required this.message, @required this.context});

  @override
  String toString() {
    return "SENDMESSAGETOFRIEND";
  }
}

//初始化聊天记录的数据
class InitChatHisStory extends WebSocketEvent {
  BuildContext context;
  String currentUserAccount;
  String friendAccount;

  InitChatHisStory({
    @required this.context,
    @required this.currentUserAccount,
    @required this.friendAccount,
  });

  @override
  String toString() {
    return "INITCHAtHISTORY";
  }
}

class DisPoseSocket extends WebSocketEvent {
  @override
  String toString() {
    return "DISPOSESOCKET";
  }
}
