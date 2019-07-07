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
  DateTime birthday; //出生日期
  String address; //地址
  User(
      {@required account,
      @required nickname,
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
}
