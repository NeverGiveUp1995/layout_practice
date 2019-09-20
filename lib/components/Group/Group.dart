/**
 * 好友分组展开收缩组件
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/friend/groups_entity.dart';
import 'dart:math' as math;

import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/views/Chat/Chat.dart';

class Group extends StatefulWidget {
  String groupName; //当前分组名称
  int onlineFriendNum; //该分组的在线人数
  int totalFriendNum; //该分组的总人数
  List<GroupsDataUser> friends; //该分组的好友列表
  Group({
    @required this.groupName,
    @required this.onlineFriendNum,
    @required this.totalFriendNum,
    friends,
  }) {
    if (friends != null) {
      this.friends = friends;
    } else {
      this.friends = List<GroupsDataUser>();
    }
  }

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> with TickerProviderStateMixin {
  bool _isOpen = false;
  ThemeBloc _themeBloc;
  AnimationController rotateAnimationController; //小图标旋转动画控制器
  Animation animation;

  @override
  void initState() {
    super.initState();
    rotateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    animation =
        Tween<double>(begin: 0.0, end: 90.0).animate(rotateAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    rotateAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      if (_isOpen) {
                        rotateAnimationController.reverse();
                      } else {
                        rotateAnimationController.forward();
                      }
                      this.setState(() {
                        _isOpen = !_isOpen;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Transform.rotate(
                          angle: math.pi * (animation.value / 180),
                          child: Icon(
                            Icons.arrow_right,
                            color: _themeState.theme != null
                                ? _themeState.theme.textColor
                                : null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.groupName,
                            style: TextStyle(
                              color: _themeState.theme != null
                                  ? _themeState.theme.textColor
                                  : null,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.onlineFriendNum}/${widget.totalFriendNum}',
                          style: TextStyle(
                            color: _themeState.theme != null
                                ? _themeState.theme.textColor
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )),
              _isOpen
                  ? Container(
                      child: Column(
                        children: widget.friends != null
                            ? widget.friends
                                .map(
                                  (friendItem) => FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Chat(
                                                    title: friendItem.nickName,
                                                    receiverAccount:
                                                        friendItem.account,
                                                  )));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      child: Row(
                                        children: <Widget>[
                                          Header(
                                            imgSrc: friendItem.headerImg,
                                            height: 55.0,
                                            width: 55.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  friendItem.nickName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  friendItem.online
                                                      ? "[在线]"
                                                      : '[离线]',
                                                  style: TextStyle(
                                                      color: Colors.black26),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                            : [Container()],
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
