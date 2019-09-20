import 'package:flutter/cupertino.dart';
/**
 * 【联系人tabView】
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/group/bloc.dart';

import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Group/Group.dart';
import 'package:layout_practice/modals/friend/groups_entity.dart';

class ContactsTabView extends StatefulWidget {
  @override
  _ContactsTabViewState createState() => _ContactsTabViewState();
}

class _ContactsTabViewState extends State<ContactsTabView>
    with TickerProviderStateMixin {
  ThemeBloc _themeBloc;
  TabController _tabController;
  GroupBloc _groupBloc;
  AuthBloc _authBloc;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _groupBloc = BlocProvider.of<GroupBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    //如果当前分组bloc中的分组信息为null，说明是第一次进入，发送获取分组的请求，获取分组信息
    if (_groupBloc.currentState.groups == null) {
      print(
          "\n\n\n\n\n=======================【联系人请求】===============================\n\n");
      _groupBloc.dispatch(
          GetGroups(userAccount: _authBloc.currentState.user.account));
    }
    List<Widget> tabNames = [
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          '好友',
          style: TextStyle(color: _themeBloc.currentState.theme.textColor),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          '群组',
          style: TextStyle(color: _themeBloc.currentState.theme.textColor),
        ),
      ),
    ];
    _tabController = TabController(length: tabNames.length, vsync: this);
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return BlocBuilder(
          bloc: _groupBloc,
          builder: (BuildContext context, GroupState groupState) {
            return Container(
              color: _themeState.theme != null
                  ? _themeState.theme.bodyColor
                  : null,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    color: _themeState.theme != null
                        ? _themeState.theme.bodyColor
                        : null,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xaaefefef),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: TextField(
                        cursorColor: _themeState.theme.textFieldCursorColor,
                        cursorWidth: 1.5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "搜索好友",
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black26),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    color: _themeState.theme != null
                        ? _themeState.theme.bodyColor
                        : null,
                    child: TabBar(controller: _tabController, tabs: tabNames),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: _themeState.theme != null
                            ? _themeState.theme.bodyColor
                            : null,
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: tabNames
                            .map((tabItem) => Container(
                                  height: 30,
                                  child: CupertinoScrollbar(
                                    child: SingleChildScrollView(
                                      child: Center(
                                          child: Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: _groupBloc
                                                      .currentState.groups !=
                                                  null
                                              ? _groupBloc.currentState.groups
                                                  .map((groupItem) => Group(
                                                        groupName: groupItem
                                                                    .friendGroupName !=
                                                                null
                                                            ? groupItem
                                                                .friendGroupName
                                                            : "未知分组名称",
                                                        onlineFriendNum:
                                                            groupItem.onlineNum !=
                                                                    null
                                                                ? groupItem
                                                                    .onlineNum
                                                                : 0,
                                                        totalFriendNum:
                                                            groupItem.users !=
                                                                    null
                                                                ? groupItem
                                                                    .users
                                                                    .length
                                                                : 0,
                                                        friends: groupItem
                                                                    .users !=
                                                                null
                                                            ? groupItem.users
                                                            : [],
                                                      ))
                                                  .toList()
                                              : [],
                                        ),
                                      )),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
