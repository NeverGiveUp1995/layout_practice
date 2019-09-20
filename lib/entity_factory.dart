import 'package:layout_practice/modals/friend/add_friend_entity.dart';
import 'package:layout_practice/modals/friend/check_friend_entity.dart';
import 'package:layout_practice/modals/friend/groups_entity.dart';
import 'package:layout_practice/modals/friend/search_user_entity.dart';
import 'package:layout_practice/modals/login_modal/login_entity.dart';
import 'package:layout_practice/modals/message/message_list_entity.dart';
import 'package:layout_practice/modals/message/single_message_result_entity.dart';
import 'package:layout_practice/modals/ReseponseData/response_data_entity.dart';
import 'package:layout_practice/modals/user/user_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "AddFriendEntity") {
      return AddFriendEntity.fromJson(json) as T;
    } else if (T.toString() == "CheckFriendEntity") {
      return CheckFriendEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupsEntity") {
      return GroupsEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchUserEntity") {
      return SearchUserEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "MessageListEntity") {
      return MessageListEntity.fromJson(json) as T;
    } else if (T.toString() == "SingleMessageResultEntity") {
      return SingleMessageResultEntity.fromJson(json) as T;
    } else if (T.toString() == "ResponseDataEntity") {
      return ResponseDataEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}