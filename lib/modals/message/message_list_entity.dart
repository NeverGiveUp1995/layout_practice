import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';

class MessageListEntity {
  List<Message> data;
  dynamic tip;
  String status;

  MessageListEntity({this.data, this.tip, this.status});

  MessageListEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Message>();
      (json['data'] as List).forEach((v) {
        data.add(new Message.fromJson(v));
      });
    }
    tip = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.tip;
    data['status'] = this.status;
    return data;
  }
}

class MessageListData {
  String sendContent;
  User receiver;
  User sender;
  int conversationId;
  int messageId;
  String sentTime;

  MessageListData(
      {this.sendContent,
      this.receiver,
      this.sender,
      this.conversationId,
      this.messageId,
      this.sentTime});

  MessageListData.fromJson(Map<String, dynamic> json) {
    sendContent = json['sendContent'];
    receiver =
        json['receiver'] != null ? new User.fromJson(json['receiver']) : null;
    sender = json['sender'] != null ? new User.fromJson(json['sender']) : null;
    conversationId = json['conversationId'];
    messageId = json['messageId'];
    sentTime = json['sentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sendContent'] = this.sendContent;
    if (this.receiver != null) {
      data['receiver'] = this.receiver.toJson();
    }
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    data['conversationId'] = this.conversationId;
    data['messageId'] = this.messageId;
    data['sentTime'] = this.sentTime;
    return data;
  }
}
