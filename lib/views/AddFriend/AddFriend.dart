import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/friend/bloc.dart';
import 'package:layout_practice/blocs/group/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
/**
 * 确认添加好友的页面
 */

class AddFriend extends StatefulWidget {
  UserData user; //目标用户对象信息
  AddFriend({@required this.user});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  FriendBloc _friendBloc;
  AuthBloc _authBloc;
  GroupBloc _groupBloc;
  WebSocketBloc _webSocketBloc; //发送消息的bloc
  int currentGroupId = null; //当前选中的分组id
  String currentGroupName = ""; //当前选中的分组id
  TextEditingController _applicationMsgController =
      TextEditingController(); //验证消息框的编辑控制器
  TextEditingController _notesController = TextEditingController(); //备注名称编辑框控制器
  /**
   * 发送申请
   */
  sendApplication(BuildContext context) {
    _webSocketBloc.dispatch(SendMessageToFriend(
        message: Message(
          receiver: User(
            account: widget.user.account,
            headerImg: widget.user.headerImg,
            nickname: widget.user.nickName,
          ),
          sendTime: Utils.getCurrentTimeString(),
          sender: _authBloc.currentState.user,
          content: _applicationMsgController.text,
          msgType: "1",
        ),
        context: context));
    Utils.showTip(context: context, tipText: "验证消息已发送,请等待对方同意", duration: 1500);
  }

  @override
  Widget build(BuildContext context) {
    _friendBloc = BlocProvider.of<FriendBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _groupBloc = BlocProvider.of<GroupBloc>(context);
    _webSocketBloc = BlocProvider.of<WebSocketBloc>(context);

    UserData user = widget.user ?? null;
    String headerImg;
    String nickName;
    String address;
    String gender;
    int age;
    if (user != null) {
      headerImg = user.headerImg;

      age = user.birthday != null &&
              user.birthday != "" &&
              user.birthday.split('-')[0] != null
          ? DateTime.now().year - int.parse(user.birthday.split('-')[0])
          : 0;
      nickName = user.nickName;
      address = user.address;
      gender = user.gender == "1" ? "男" : '女';
    }
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState authState) {
        if (_groupBloc.currentState.groups == null) {
          _groupBloc.dispatch(GetGroups(userAccount: authState.user.account));
        }
        return BlocBuilder(
          bloc: _friendBloc,
          builder: (BuildContext context, FriendState friendState) {
            return BlocBuilder(
              bloc: _groupBloc,
              builder: (BuildContext context, GroupState groupState) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "添加好友",
                      style: TextStyle(fontSize: 16),
                    ),
                    centerTitle: true,
                    elevation: 0,
                    actions: <Widget>[
                      UnconstrainedBox(
                        child: FloatingActionButton(
                          backgroundColor: Color(0x00000000),
                          foregroundColor: Colors.black54,
                          focusColor: Color(0x00000000),
                          hoverColor: Color(0x00000000),
                          elevation: 0,
                          highlightElevation: 0,
                          onPressed: () => this.sendApplication(context),
                          child: Text("发送"),
                        ),
                      )
                    ],
                    leading: BackBtn(),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: Utils.getScreenSize().height - 80),
                      child: Column(
                        children: <Widget>[
                          //==========================================================【用户信息】
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 60,
                            child: Row(
                              children: <Widget>[
                                Header(
                                  height: 50,
                                  width: 50,
                                  imgSrc: headerImg,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          nickName ?? "未知用户名称",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                gender ?? "未公开",
                                                style: TextStyle(
                                                    color: Colors.black38),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                "$age岁",
                                                style: TextStyle(
                                                    color: Colors.black38),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                address ?? "未公开",
                                                style: TextStyle(
                                                    color: Colors.black38),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //==========================================================【验证消息框】
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0xddefefef),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: _applicationMsgController,
                                    maxLength: 50,
                                    //最多50个字
                                    maxLines: null,
                                    //取消默认的最大行数为1的设置，表示可以多行
                                    cursorWidth: 1,
                                    cursorColor: Colors.black12,
                                    expands: true,
                                    //光标宽度
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //==========================================================【备注和选择分组】
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
                                  child: Text(
                                    "设置备注和分组",
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Color(0xddededed),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 28),
                                              child: Text("备注"),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextField(
                                                controller: _notesController,
                                                maxLines: null,
                                                minLines: null,
                                                cursorWidth: 0.5,
                                                cursorColor: Colors.black38,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text("分组"),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        builder: (BuildContext
                                                            context) {
                                                          return Stack(
                                                            children: <Widget>[
                                                              Container(
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15)),
                                                                ),
                                                                width: Utils.getScreenSize()
                                                                        .width -
                                                                    20,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        10),
                                                                height: Utils
                                                                            .getScreenSize()
                                                                        .height *
                                                                    .8,
                                                                child: ListView(
                                                                    children: groupState
                                                                        .groups
                                                                        .map(
                                                                          (groupItem) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border(bottom: BorderSide(width: .5, style: BorderStyle.solid, color: Color(0xddefefef)))),
                                                                            child:
                                                                                FlatButton(
                                                                              padding: EdgeInsets.all(0),
                                                                              color: currentGroupId == groupItem.groupId ? Colors.blue : null,
                                                                              child: Text(
                                                                                groupItem.friendGroupName,
                                                                                style: TextStyle(color: currentGroupId == groupItem.groupId ? Colors.white : null),
                                                                              ),
                                                                              onPressed: () {
                                                                                this.setState(() {
                                                                                  this.currentGroupId = groupItem.groupId;
                                                                                  this.currentGroupName = groupItem.friendGroupName;
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        )
                                                                        .toList()),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                        context: context);
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          child: Text(
                                                            currentGroupName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 15,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 14,
                                                          color: Colors.black26,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
