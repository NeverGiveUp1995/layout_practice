import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {
  get password => null;

  get userAccount => null;
}

@immutable
class LoginEvent extends AuthEvent {
  BuildContext buildContext;
  String userAccount;
  String password;

  LoginEvent(this.buildContext, this.userAccount, this.password);

  @override
  String toString() => "Login{userAccount:$userAccount,password:$password}";
}

class RegisterEvent extends AuthEvent {
  BuildContext context;
  String userAccount;
  String password;
  String nickName;
  String phoneNum;
  String email;
  String gender;
  Function callback;

  RegisterEvent(
      {@required this.context,
      @required this.userAccount,
      @required this.password,
      @required this.nickName,
      @required this.phoneNum,
      @required this.gender,
      callback,
      email}) {
    this.email = email;
    this.callback = callback;
  }
}

class CheckAccount extends AuthEvent {
  String account;
  BuildContext context;
  Function callback;

  CheckAccount({
    @required this.context,
    @required this.callback,
    @required this.account,
  });

  @override
  String toString() {
    return "CheckAccount";
  }
}

//验证电话号码事件
class CheckPhoneNum extends AuthEvent {
  String phoneNum;
  BuildContext context;
  Function callback;

  CheckPhoneNum({
    @required this.context,
    @required this.callback,
    @required this.phoneNum,
  });

  @override
  String toString() {
    return "CheckPhoneNum";
  }
}

class Logout extends AuthEvent {
  @override
  String toString() => "Logout";
}
