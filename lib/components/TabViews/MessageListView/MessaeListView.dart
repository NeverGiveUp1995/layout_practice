import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/views/Chat/Chat.dart';

class MessageListView extends StatelessWidget {
  ThemeBloc _themeBloc;
  AuthBloc _authBloc;
  MessageBloc _messageBloc;

  MessageListView({@required messageList, @required themeBloc}) {
    this._themeBloc = themeBloc;
  }

  _openChatPage(BuildContext context, String nickName, String userAccount) {
    print("正在跳转到与$nickName的聊天页面");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          title: nickName,
          receiverAccount: userAccount,
        ),
      ),
    );
  }

  List<Widget> _renderMessageList(
      AuthBloc _authBloc, ThemeBloc _themeBloc, BuildContext context) {
    List<Widget> messages = [];
    List<Message> messageList = List<Message>();
    if (this._messageBloc != null &&
        this._messageBloc.currentState != null &&
        this._messageBloc.currentState.messageList != null) {
      messageList = this._messageBloc.currentState.messageList;
    }
    if (messageList != null && messageList.length > 0) {
      for (int i = 0;
          i < this._messageBloc.currentState.messageList.length;
          i++) {
        Message item = messageList[i];
        User targetUser = null;
        if (item.sender != null &&
            _authBloc.currentState.user != null &&
            item.sender.account != _authBloc.currentState.user.account) {
          targetUser = item.sender;
        } else {
          targetUser = item.receiver;
        }
        messages.add(
          FlatButton(
            color: Color(0x00000000),
            onPressed: () =>
                _openChatPage(context, targetUser.nickName, targetUser.account),
            child: Container(
                height: 65.0,
                padding: EdgeInsets.all(3),
                child: Row(
                  children: <Widget>[
                    Header(
                      width: 60.00,
                      height: 60.00,
                      borderColor: Color(0x00000000),
                      borderWidth: 0.0,
                      imgSrc: targetUser.headerImg,
                      padding: 6.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                          昵称，或者备注，消息时间
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                                昵称、备注
                                Text(
                                  targetUser.remark != null
                                      ? targetUser.remark //备注优先显示
                                      : targetUser.nickName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        _themeBloc.currentState.theme != null &&
                                                _themeBloc.currentState.theme
                                                        .textColor !=
                                                    null
                                            ? _themeBloc
                                                .currentState.theme.textColor
                                            : null,
                                  ),
                                ),
//                                消息时间
                                Opacity(
                                  opacity: .5,
                                  child: Text(
                                    item.sendTime != null ? item.sendTime : '',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: _themeBloc.currentState.theme !=
                                                  null &&
                                              _themeBloc.currentState.theme
                                                      .textColor !=
                                                  null
                                          ? _themeBloc
                                              .currentState.theme.textColor
                                          : null,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
//                          消息内容（预览）
                            Opacity(
                              opacity: .5,
                              child: Container(
                                padding: EdgeInsets.only(top: 3, right: 15),
                                child: Text(
                                  item.content != null ? item.content : '.',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        _themeBloc.currentState.theme != null &&
                                                _themeBloc.currentState.theme
                                                        .textColor !=
                                                    null
                                            ? _themeBloc
                                                .currentState.theme.textColor
                                            : null,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      }
    }
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState authState) {
            return BlocBuilder(
              bloc: _messageBloc,
              builder: (BuildContext context, MessageState messageState) {
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
                          child: SizedBox.expand(
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/searchFriend');
                                },
                                child: Text(
                                  '搜索好友',
                                  style: TextStyle(color: Colors.black26),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: Utils.getScreenSize().height - 40),
                              child: RefreshIndicator(
                                child: ListView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  children: _renderMessageList(
                                      _authBloc, _themeBloc, context),
                                ),
                                onRefresh: () {
                                  Future<String> result =
                                      Future.delayed(Duration(), () {
                                    if (authState != null &&
                                        authState.user != null &&
                                        authState.user.account != null) {
                                      print("正在重新获取消息列表");
                                      _messageBloc.dispatch(GetMessageList(
                                          authState.user.account));
                                    } else {
                                      print("当前用户未知，无法刷新");
                                    }
                                  });
                                  return result;
                                },
                              ),
                            ),
                          ))
                    ],
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
