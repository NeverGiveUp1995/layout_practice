import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:layout_practice/modals/ServerIp.dart';
import 'package:layout_practice/modals/friend/groups_entity.dart';
import 'package:layout_practice/utils/request.dart';
import './bloc.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  @override
  GroupState get initialState => InitialGroupState();

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if (event is GetGroups) {
      //如果是获取分组的事件，发送请求，获取分组

      var response = await NetServer.request(
        api: '/friend/getGroupsByUserAccount',
        method: 'post',
        params: {"userAccount": event.userAccount},
      );
      GroupsEntity groupsEntity =
          GroupsEntity.fromJson(json.decode(response.toString()));
      if (groupsEntity.data != null) {
        yield Groups(groups: groupsEntity.data);
      }
      print("获取结果：$groupsEntity");
    }
  }
}
