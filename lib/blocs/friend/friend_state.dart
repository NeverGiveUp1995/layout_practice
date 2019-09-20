import 'package:layout_practice/modals/friend/search_user_entity.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FriendState {
  List<SearchUserData> userResuls = [];

  get isFriend => null;
  UserData userData;

  FriendState({this.userData, this.userResuls});
}

class InitialFriendState extends FriendState {}

class IsFriend extends FriendState {
  dynamic isFriend;

  IsFriend({@required this.isFriend});
}

class UserDetailInfoState extends FriendState {
  UserData userData;

  UserDetailInfoState({@required this.userData}) : super(userData: userData);
}

/**
 * 搜索页的用户列表
 */
class UserListOfSearchPage extends FriendState {
  List<SearchUserData> userResuls = [];

  UserListOfSearchPage({@required this.userResuls}) : super(userResuls: userResuls);
}
