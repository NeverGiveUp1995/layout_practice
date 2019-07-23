import 'package:layout_practice/modals/login_modal/User.dart';

 class LoginEntity {
  User data;
  dynamic message;
  String status;

  LoginEntity({this.data, this.message, this.status});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
