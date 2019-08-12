import 'package:layout_practice/modals/message/Message.dart';
import 'package:flutter/material.dart';

/**
 * 与某个好友的聊天记录实体类
 */
class MessageHistoryWithFriend {
  List<Message> messageHistory; //与该好友的所有聊天记录

  MessageHistoryWithFriend({
    @required this.messageHistory,
  });

  MessageHistoryWithFriend.fromJson(Map<String, dynamic> json) {
    messageHistory = new List<Message>();
    (json['messageHistory'] as List).forEach((message) {
      messageHistory.add(
        Message.fromJson(message),
      );
    });
    messageHistory = json['messageHistory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();
    if (result != null) {
      result['messageHistory'] =
          this.messageHistory.map((message) => message.toJson()).toList();
    }
    return result;
  }
}
