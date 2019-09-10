import 'package:meta/meta.dart';

@immutable
abstract class NoticeState {
  bool isShow;
  int noticeId; //通知id
  String title; //通知标题
  String content; //通知内容(必传)
  String senderAccount; //发送者的用户id
  String senderName; //发送这的名称：优先顺序为：备注---->昵称
  String imgSrc; //附带图片地址
}

class InitialNoticeState extends NoticeState {}

class NotificationState extends NoticeState {
  bool isShow; //通知是否显示
  int noticeId; //通知id
  String content; //通知内容(必传)
  String senderAccount; //发送者的用户id
  String senderName; //发送这的名称：优先顺序为：备注---->昵称
  String imgSrc; //附带图片地址
  NotificationState(
      {@required this.isShow,
      @required this.noticeId,
      this.senderAccount,
      this.senderName,
      @required this.content,
      this.imgSrc});
}
