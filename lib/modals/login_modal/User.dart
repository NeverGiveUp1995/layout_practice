import 'package:flutter/material.dart';

class User {
  String account; //账号（id：主键）
  String nickName; //昵称
  String remark; //备注
  String phoneNum; //电话号码
  String email; //邮箱
  String password; //密码
  String headerImg; //头像地址
  String sex = "1"; //性别：1：男；2：女
  String birthday; //出生日期
  String address; //地址
  String chatBgImgSrc; //聊天背景图片地址
  User(
      {@required account,
      nickname,
      password,
      phoneNum,
      email,
      headerImg,
      sex,
      birthday,
      address}) {
    this.account = account;
    this.nickName = nickname;
    this.phoneNum = phoneNum;
    this.email = email;
    this.headerImg = headerImg;
    this.sex = sex;
    this.birthday = birthday;
    this.address = address;
  }

  User.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    password = json['password'];
    address = json['address'];
    nickName = json['nickName'];
    sex = json['sex'];
    phoneNum = json['phoneNum'];
    account = json['account'];
    email = json['email'];
    headerImg = json['headerImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['password'] = this.password;
    data['address'] = this.address;
    data['nickName'] = this.nickName;
    data['sex'] = this.sex;
    data['phoneNum'] = this.phoneNum;
    data['account'] = this.account;
    data['email'] = this.email;
    data['headerImg'] = this.headerImg;
    return data;
  }
}
