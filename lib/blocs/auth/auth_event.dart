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

class Logout extends AuthEvent {
  @override
  String toString() => "Logout";
}
