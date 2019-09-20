import 'package:flutter/material.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FriendEvent {}

class CheckFriendEvent extends FriendEvent {
  String activeUserAccount; //发起检查的用户账号
  String passiveUserAccount; //被检查的用户账号

  CheckFriendEvent(
      {@required this.activeUserAccount, @required this.passiveUserAccount});

  @override
  String toString() {
    return "CheckFriendEvent";
  }
}

class AddFriendEvent extends FriendEvent {
  String activeUserAccount; //发起添加操作的用户账号
  String passiveUserAccount; //被添加的用户账号
  BuildContext context; //弹出提示框需要
  AddFriendEvent({
    @required this.activeUserAccount,
    @required this.passiveUserAccount,
    @required this.context,
  });

  @override
  String toString() {
    return "AddFriendEvent";
  }
}

class InitUserInfoEvent extends FriendEvent {
  String userAccount;
  UserData user;

  InitUserInfoEvent({@required this.userAccount, this.user});

  @override
  String toString() {
    return "InitUserInfoEvent";
  }
}

class SetIsFriend extends FriendEvent {
  dynamic isFriend;

  SetIsFriend({@required this.isFriend});
}

class SearchUserEvent extends FriendEvent {
  String keyWords;

  SearchUserEvent({@required this.keyWords});

  @override
  String toString() {
    return "SearchUserEvent";
  }
}
