import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState {
  User user;
  bool loggedIn = false; //是否登录成功
  String message = "";
}

class UserState extends AuthState {
  User user;
  bool loading = true;
  bool loggedIn = false; //是否登录成功
  UserState({User data, loggedIn, user, message}) {
    this.user = user;
    this.message = message;
    this.loggedIn = loggedIn;
  }

  @override
  String toString() => "User:$user";
}
