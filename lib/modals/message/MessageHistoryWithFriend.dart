import 'dart:convert';

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
    if (json['messageHistory'] != null) {
      messageHistory = new List<Message>();
      (json['messageHistory'] as List).forEach((v) {
        messageHistory.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();
    if (result != null) {
      result['messageHistory'] = this.messageHistory.map((message) {
        return message.toJson();
      }).toList();
    }
    return result;
  }

  @override
  String toString() {
    var jsonData = toJson();
//   注意： 写入的数据有可能存在null值，此时存入的应为【"null"】而不是【null】
//    String resultStr = json.encode(jsonData).replaceAll(':null', ':"null"');
    String resultStr = json.encode(jsonData);
    return resultStr;
  }
}
