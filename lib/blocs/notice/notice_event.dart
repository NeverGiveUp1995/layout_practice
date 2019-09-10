import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NoticeEvent {}

class PublishNotice extends NoticeEvent {
  bool isShow;
  int noticeId; //通知id
  String content; //通知内容(必传)
  String senderAccount; //发送者的用户id
  String senderName; //发送这的名称：优先顺序为：备注---->昵称
  String imgSrc; //附带图片地址
  PublishNotice(
      {@required this.isShow,
      this.noticeId,
      this.content,
      this.senderAccount,
      this.senderName,
      this.imgSrc});

  @override
  String toString() {
    return "PublishNotice";
  }
}
