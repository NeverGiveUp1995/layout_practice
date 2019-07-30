import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/Message.dart';
import 'package:layout_practice/views/Chat/Chat.dart';

class MessageListView extends StatelessWidget {
  List<Message> messageList = [];
  ThemeBloc _themeBloc;

  MessageListView({@required messageList, @required themeBloc}) {
    this.messageList = messageList;
    this._themeBloc = themeBloc;
  }

  _openChatPage(BuildContext context, String nickName) {
    print("正在跳转到与$nickName的聊天页面");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Chat(
                title: nickName,
              )),
    );
  }

  List<Widget> _renderMessageList(BuildContext context) {
    _themeBloc = BlocProvider.of(context);
    List<Widget> messages = [];
    for (int i = 0; i < this.messageList.length; i++) {
      Message item = this.messageList[i];
      messages.add(
        FlatButton(
          color: Color(0x00000000),
          onPressed: () => _openChatPage(context, item.sender.nickName),
          child: Container(
              height: 60.00,
              padding: EdgeInsets.all(3),
              child: Row(
                children: <Widget>[
                  Header(
                      width: 55.00,
                      height: 55.00,
                      borderColor: Color(0x00000000),
                      borderWidth: 0.0,
                      imgSrc: item.sender.headerImg),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          昵称，或者备注，消息时间
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                                昵称、备注
                              Text(
                                item.sender.remark != null
                                    ? item.sender.remark //备注优先显示
                                    : item.sender.nickName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _themeBloc.currentState.theme !=
                                              null &&
                                          _themeBloc.currentState.theme
                                                  .textColor !=
                                              null
                                      ? _themeBloc.currentState.theme.textColor
                                      : null,
                                ),
                              ),
//                                消息时间
                              Opacity(
                                opacity: .5,
                                child: Text(
                                  item.sendTime,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color:
                                        _themeBloc.currentState.theme != null &&
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
                              padding: EdgeInsets.only(top: 3, right: 20),
                              child: Text(
                                item.messageContent,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _themeBloc.currentState.theme !=
                                              null &&
                                          _themeBloc.currentState.theme
                                                  .textColor !=
                                              null
                                      ? _themeBloc.currentState.theme.textColor
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
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of(context);
    return Container(
      color: _themeBloc.currentState.theme != null
          ? _themeBloc.currentState.theme.bodyColor
          : Color(0x000f0f0f),
      child: RefreshIndicator(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: this._renderMessageList(context),
          ),
        ),
        onRefresh: () {
          Future<String> result = null;
          result = Future.delayed(Duration(), () {
            print("正在重新获取消息列表");
          });
          return result;
        },
      ),
    );
  }
}
