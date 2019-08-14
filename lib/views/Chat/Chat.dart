import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/message/single_message_result_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/webSocket/MessageUtils.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Chat extends StatefulWidget {
  @required
  String title; //当前正在聊天的对象名称（好友备注/名称,群名称）
  String receiverAccount; //当前正在聊天的对象id
  BuildContext context; //组件上下文
  List<Message> messageListData; //聊天记录的数据
  Chat(
      {Key key,
      @required this.title,
      @required this.receiverAccount,
      @required this.messageListData})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ThemeBloc _themeBloc;
  WebSocketBloc _webSocketBloc;
  AuthBloc _authBloc; //用户信息
  bool _canSendMsg = false; //是否满足发送消息的条件（文本框有文字）
  WebSocketChannel channel;

//  文本框编辑控制器
  TextEditingController _controller = new TextEditingController();

//  聊天记录的滚动控制器
  ScrollController _scrollController = new ScrollController();
  String _text = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /**
   * 发送消息的方法
   */
  void _sendMessage(WebSocketBloc webSocketBloc) {
    String msg = _controller.text;
    if (msg.isNotEmpty) {
      print("马上发送消息：${msg}");
      _controller.text = "";
      webSocketBloc.dispatch(
        SendMessageToFriend(
          message: Message(
            receiver: User(account: widget.receiverAccount),
            sender: _authBloc.currentState.user,
            content: msg,
          ),
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

  Widget _renderMessageRecordList(List<Message> messageListData) {
    print("正在渲染聊天信息");
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
                        width: 50.0,
                        height: 50.0,
                        borderWidth: 0.0,
                        borderColor: null,
                        imgSrc: messageItem.sender.headerImg,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //                        头像
                      Header(
                        width: 50.0,
                        height: 50.0,
                        borderWidth: 0.0,
                        borderColor: null,
                        imgSrc: messageItem.sender.headerImg,
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
    _authBloc = Provider.of<AuthBloc>(context);
    _themeBloc = Provider.of<ThemeBloc>(context);
    _webSocketBloc = Provider.of<WebSocketBloc>(context);
    print(_webSocketBloc.currentState.messageHistoryWithFriend != null &&
            _webSocketBloc
                    .currentState.messageHistoryWithFriend.messageHistory !=
                null
        ? _webSocketBloc.currentState.messageHistoryWithFriend.messageHistory
        : "聊天页面没获取到数据");
    MessageUtils.connect(_authBloc.currentState.user.account, context);
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState authState) {
            return BlocBuilder(
                bloc: _webSocketBloc,
                builder: (BuildContext context, WebSocketState webSocketState) {
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: _themeState.theme != null &&
                              _themeState.theme.titleBarBGColor != null
                          ? _themeState.theme.titleBarBGColor
                          : null,
                      //设置阴影辐射范围
                      title: Text(
                        this.widget.title,
                        style: TextStyle(
                            color: _themeState.theme != null &&
                                    _themeState.theme.titleBarTextColor != null
                                ? _themeState.theme.titleBarTextColor
                                : null,
                            fontSize: 16),
                      ),
                    ),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
//                聊天记录面板
                          child: Container(
                            color: _themeState.theme != null &&
                                    _themeState.theme.bodyColor != null
                                ? _themeState.theme.bodyColor
                                : null,
                            child: _renderMessageRecordList(
                              _webSocketBloc.currentState.messageHistoryWithFriend !=
                                          null &&
                                      _webSocketBloc
                                              .currentState
                                              .messageHistoryWithFriend
                                              .messageHistory !=
                                          null
                                  ? _webSocketBloc.currentState
                                      .messageHistoryWithFriend.messageHistory
                                  : List<Message>(),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: _themeState.theme != null &&
                                    _themeState.theme.bodyColor != null
                                ? _themeState.theme.bodyColor
                                : null,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 3),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            constraints:
                                BoxConstraints(maxHeight: 150, minHeight: 38),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.00)),
                                  ),
                                  child: FlatButton(
                                    color: _canSendMsg
                                        ? Colors.white
                                        : Color(0xeeefefef),
                                    onPressed: _controller.text.isNotEmpty
                                        ? () => _sendMessage(_webSocketBloc)
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
                  );
                });
          },
        );
      },
    );
  }
}
