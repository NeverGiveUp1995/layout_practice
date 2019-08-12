import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';

/***
 * 聊天过程中，接收的消息格式（包含该次接收的数据状态）
 */
class SingleMessageResultEntity {
  Message data;
  String status;
  String tip;

  SingleMessageResultEntity({this.data, this.status});

  SingleMessageResultEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Message.fromJson(json['data']) : null;
    status = json['status'];
    tip = json['tip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['tip'] = this.tip;
    return data;
  }
}
