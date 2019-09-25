import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/webSocket/MessageUtils.dart';
import 'package:layout_practice/views/PersonalDetails/PersonalDetails.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @required
  String title; //当前正在聊天的对象名称（好友备注/名称,群名称）
  String receiverAccount; //当前正在聊天的对象id
  String msgType; //消息类型：1.系统消息，2.私人消息，3.群组消息,
  BuildContext context; //组件上下文
  Chat({
    Key key,
    @required this.title,
    @required this.receiverAccount,
    @required this.msgType,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ThemeBloc _themeBloc;
  WebSocketBloc _webSocketBloc;
  AuthBloc _authBloc; //用户信息
  bool _canSendMsg = false; //是否满足发送消息的条件（文本框有文字）
  Color _bodyBgColor = null; //默认不设置
  Color _appBarBgColor = null; //默认不设置
//  文本框编辑控制器
  TextEditingController _controller = new TextEditingController();

//  聊天记录的滚动控制器
  ScrollController _scrollController = new ScrollController();
  String _text = "";

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /**
   * 发送消息的方法,
   * msgType:消息类型：0：系统消息；1：私人消息，2：群组消息
   */
  void _sendMessage(WebSocketBloc webSocketBloc, String msgType) {
    String msg = _controller.text;
    if (msg.isNotEmpty) {
      print("马上发送消息给${widget.receiverAccount}：${msg}");
      _controller.text = "";
      webSocketBloc.dispatch(
        SendMessageToFriend(
          message: Message(
            receiver: User(
              account: widget.receiverAccount,
            ),
            sender: _authBloc.currentState.user,
            content: msg,
            sendTime: Utils.getCurrentTimeString(),
            msgType: msgType,
          ),
          context: context,
        ),
      );
      print("发送完毕！");
    }
  }

  void _onMsgChange(text) {
//    如果输入框不为空
    if (_controller.text.isNotEmpty) {
      this.setState(() {
        this._canSendMsg = true;
      });
    }
//    如果输入框内容为空
    if (_controller.text.isEmpty) {
      this.setState(() {
        this._canSendMsg = false;
      });
    }
  }

  _scrollToBottom(int duration) {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: duration), curve: Curves.ease);
  }

  /**
   * 查看个人详情
   */
  _showPerSonDetail(
      {@required BuildContext context, User user, String userAccount}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PersonalDetails(
              userAccount: userAccount,
              isFriend: true,
            )));
  }

  Widget _renderMessageRecordList(List<Message> messageListData) {
    List<Widget> messageList = List();
    if (messageListData != null && messageListData.length > 0) {
      messageListData.forEach((messageItem) {
        messageList.add(
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: _authBloc.currentState != null &&
                    _authBloc.currentState.user != null &&
                    messageItem.sender.account ==
                        _authBloc.currentState.user.account
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //消息部分
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 8, top: 5),
                        constraints: BoxConstraints(
                          maxWidth: Utils.getScreenSize().width - 140,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          messageItem.content,
                          softWrap: true,
                        ),
                      ),
//                        头像
                      Header(
                        width: 40.0,
                        height: 40.0,
                        borderWidth: 0.0,
                        borderColor: null,
                        imgSrc: messageItem.sender.headerImg,
                        onClick: () {
                          _showPerSonDetail(
                              context: context,
                              userAccount: messageItem.sender.account);
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //                        头像
                      Header(
                        width: 40.0,
                        height: 40.0,
                        borderWidth: 0.0,
                        borderColor: null,
                        imgSrc: messageItem.sender.headerImg,
                        onClick: () {
                          _showPerSonDetail(
                              context: context,
                              userAccount: messageItem.sender.account);
                        },
                      ),
                      //消息部分
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 8, top: 5),
                        constraints: BoxConstraints(
                            maxWidth: Utils.getScreenSize().width - 140),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          messageItem.content,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      });
    }
    return CupertinoScrollbar(
        child: ListView(
      padding: EdgeInsets.all(10),
      controller: _scrollController,
      children: messageList,
      reverse: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _webSocketBloc = BlocProvider.of<WebSocketBloc>(context);

    MessageUtils.connect(_authBloc.currentState.user.account, context);
    //判断聊天blo0里面是否有当前聊天对象的数据，如果没有，从本地文件中获取数据，并初始化
    if (_webSocketBloc.currentState.messageHistoryWithFriends == null ||
        (_webSocketBloc.currentState.messageHistoryWithFriends != null &&
            _webSocketBloc.currentState
                    .messageHistoryWithFriends[widget.receiverAccount] ==
                null)) {
      _webSocketBloc.dispatch(InitChatHisStory(
        context: context,
        currentUserAccount: _authBloc.currentState.user.account,
        friendAccount: widget.receiverAccount,
      ));
    }

    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState authState) {
            //如果用户设置了聊天背景图片，则将背景色设置成透明
            if (authState.user.chatBgImgSrc != null ||
                authState.user.chatBgImgSrc != "") {
              _bodyBgColor = Color(0x00ffffff);
              _appBarBgColor = Color(0x33000000);
            } else {
              //否则使用主题颜色
              _bodyBgColor = _themeState.theme != null &&
                      _themeState.theme.bodyColor != null
                  ? _themeState.theme.bodyColor
                  : null;
              _appBarBgColor = _themeState.theme != null &&
                      _themeState.theme.titleBarBGColor != null
                  ? _themeState.theme.titleBarBGColor
                  : null;
            }
            return BlocBuilder(
                bloc: _webSocketBloc,
                builder: (BuildContext context, WebSocketState webSocketState) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568895608867&di=9406daff7d0bda92ef953a04c46a7497&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10113%2F704%2Fw1024h1280%2F20190521%2F92ce-hxhyium8625781.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Scaffold(
                        backgroundColor: Color(0x00ffffff),
                        appBar: AppBar(
                          centerTitle: true,
                          elevation: 0,
                          backgroundColor: _appBarBgColor,
                          leading: BackBtn(),
                          //设置阴影辐射范围
                          title: Text(
                            this.widget.title,
                            style: TextStyle(
                                color: _themeState.theme != null &&
                                        _themeState.theme.titleBarTextColor !=
                                            null
                                    ? _themeState.theme.titleBarTextColor
                                    : null,
                                fontSize: 16),
                          ),
                        ),
                        body: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              //        聊天记录面板
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                ),
                                child: _renderMessageRecordList(
                                  _webSocketBloc.currentState
                                                  .messageHistoryWithFriends !=
                                              null &&
                                          _webSocketBloc.currentState
                                                      .messageHistoryWithFriends[
                                                  widget.receiverAccount] !=
                                              null &&
                                          _webSocketBloc
                                                  .currentState
                                                  .messageHistoryWithFriends[
                                                      widget.receiverAccount]
                                                  .messageHistory !=
                                              null
                                      ? _webSocketBloc
                                          .currentState
                                          .messageHistoryWithFriends[
                                              widget.receiverAccount]
                                          .messageHistory
                                      : List<Message>(),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: _bodyBgColor,
                              ),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 3),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                constraints: BoxConstraints(
                                    maxHeight: 150, minHeight: 38),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              //【输入框、】
                                              child: TextField(
                                                controller: _controller,
                                                onChanged: _onMsgChange,
                                                maxLines: null,
                                                //设置光标颜色
                                                cursorColor: Color.fromRGBO(
                                                    150, 150, 150, 0),
                                                //设置光标宽度
                                                cursorWidth: 1.5,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          8, 10, 8, 10),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 【发送按钮】
                                    Container(
                                      width: 68,
                                      height: 38,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: _canSendMsg
                                            ? Colors.white
                                            : Color(0xeeefefef),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.00)),
                                      ),
                                      child: FlatButton(
                                        color: _canSendMsg
                                            ? Colors.white
                                            : Color(0xeeefefef),
                                        onPressed: _controller.text.isNotEmpty
                                            ? () => _sendMessage(
                                                _webSocketBloc, widget.msgType)
                                            : null,
                                        child: Text(
                                          '发送',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: _canSendMsg
                                                  ? null
                                                  : Color(0x88ababab)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                });
          },
        );
      },
    );
  }
}
