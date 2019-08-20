import 'package:layout_practice/modals/login_modal/User.dart';

 class LoginEntity {
  User data;
  String tip;
  String status;

  LoginEntity({this.data, this.tip, this.status});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    tip = json['tip'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['tip'] = this.tip;
    data['status'] = this.status;
    return data;
  }
}
