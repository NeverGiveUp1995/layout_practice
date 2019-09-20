import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:layout_practice/modals/friend/add_friend_entity.dart';
import 'package:layout_practice/modals/friend/check_friend_entity.dart';
import 'package:layout_practice/modals/friend/search_user_entity.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/request.dart';
import './bloc.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  @override
  FriendState get initialState => InitialFriendState();

  @override
  Stream<FriendState> mapEventToState(
    FriendEvent event,
  ) async* {
//    更改是否好友状态的事件
    if (event is SetIsFriend) {
      yield IsFriend(isFriend: event.isFriend);
    }
    //搜索好友的事件
    if (event is SearchUserEvent) {
      if (event.keyWords != "") {
        Response response = await NetServer.request(
          api: "/friend/searchUser",
          method: 'post',
          params: {"kw": event.keyWords},
        );
        SearchUserEntity searchUserEntity =
            SearchUserEntity.fromJson(json.decode(response.toString()));
        if (searchUserEntity.status == "1") {
          yield UserListOfSearchPage(userResuls: searchUserEntity.data);
        }
      } else {
        yield UserListOfSearchPage(userResuls: null);
      }
    }
    if (event is InitUserInfoEvent) {
      UserData user;
      if (event.user != null) {
        user = event.user;
      } else {
        Response response = await NetServer.request(
          api: "/user/getUserByUserAccount",
          method: 'post',
          params: {"userAccount": event.userAccount},
        );
        UserEntity userEntity =
            UserEntity.fromJson(json.decode(response.toString()));
        if (userEntity.status == "1") {
          if (userEntity.data != null) {
            user = userEntity.data;
          }
        }
      }
      yield UserDetailInfoState(userData: user);
    } else if (event is CheckFriendEvent) {
      Response response = await NetServer.request(
        api: "/friend/checkFriend",
        method: 'post',
        params: {
          "activeUserAccount": event.activeUserAccount,
          "passiveUserAccount": event.passiveUserAccount
        },
      );
      CheckFriendEntity checkFriendEntity =
          CheckFriendEntity.fromJson(json.decode(response.toString()));
      if (checkFriendEntity.status == "1") {
        if (checkFriendEntity.data != null &&
            checkFriendEntity.data.friendId != null) {
          yield IsFriend(isFriend: true);
        } else {
          yield IsFriend(isFriend: false);
        }
      }
    } else if (event is AddFriendEvent) {
      Response response = await NetServer.request(
        api: "/friend/addFriend",
        method: 'post',
        params: {
          "activeUserId": event.activeUserAccount,
          "passiveUserId": event.passiveUserAccount
        },
      );
      AddFriendEntity addFriendEntity =
          AddFriendEntity.fromJson(json.decode(response.toString()));
      if (addFriendEntity.tip != null) {
        Utils.showTip(context: event.context, tipText: addFriendEntity.tip);
        yield IsFriend(isFriend: true);
      }
    }
  }
}
