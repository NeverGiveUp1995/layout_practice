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

  static User currentUser = User(
    account: '1000',
    nickname: '夕阳醉了',
    headerImg:
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565314971&di=b834040ca41ecbf9d5b67aacf18c6afc&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201610%2F14%2F20161014211316_KWAht.jpeg',
  );
  List<Message> testData = [
    Message(
      sender: User(
        account: '1003',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:49",
      content: "你好啊！",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      sender: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:50",
      content: "欧蕾哇撒苦辣米奇！",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      receiver: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      sender: currentUser,
      sendTime: "7:51",
      content: "你是谁和我有鸡儿关系！老子不认识你，白痴",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      sender: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:52",
      content: "卧槽！你好膨胀啊",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      receiver: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      sender: currentUser,
      sendTime: "7:53",
      content: "关你卵事，屁话多！不服干一架",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      sender: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:54",
      content: "来就来，",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      sender: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:55",
      content: "公怕奶日批啊",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      receiver: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      sender: currentUser,
      sendTime: "7:56",
      content: "卧槽，你咋这么狂呢？",
      conversationId: 9,
      messageId: null,
    ),
    Message(
      sender: User(
        account: '1002',
        nickname: '樱木花道',
        headerImg:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564719991350&di=82927df92944d43d9ad43da9e9324929&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20110317%2F20110317121835-1411638974.jpg',
      ),
      receiver: currentUser,
      sendTime: "7:55",
      content:
          '错误信息：22-Mar-2019 15:15:53.542 严重 [http-nio-8080-exec-4] org.apache.catalina.core.StandardWrapperValve.invoke Servlet.service() for servlet [springmvc] in context with path [] threw exception [Request processing failed; nested exception is org.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.hn.mapper.UserMapper.findNameByUser] with root causeorg.apache.ibatis.binding.BindingException: Invalid bound statement (not found): com.hn.mapper.UserMapper.findNameByUse---------------------版权声明：本文为CSDN博主「wcdunf」的原创文章，遵循CC 4.0 by-sa版权协议，转载请附上原文出处链接及本声明。原文链接：https://blog.csdn.net/wcdunf/article/details/88742104"',
      conversationId: 9,
      messageId: null,
    ),
  ];

  _openChatPage(BuildContext context, String nickName, String userAccount) {
    print("正在跳转到与$nickName的聊天页面");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
              title: nickName,
          receiverAccount: userAccount,
              messageListData: testData,
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
    print("渲染的列表$messageList");
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
                        imgSrc: targetUser.headerImg),
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
                  color: _themeBloc.currentState.theme != null
                      ? _themeBloc.currentState.theme.bodyColor
                      : null,
                  child: RefreshIndicator(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: Utils.getScreenSize().height),
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: this
                            ._renderMessageList(_authBloc, _themeBloc, context),
                      ),
                    ),
                    onRefresh: () {
                      Future<String> result = null;
                      result = Future.delayed(Duration(), () {
                        if (authState != null &&
                            authState.user != null &&
                            authState.user.account != null) {
                          print("正在重新获取消息列表");
                          _messageBloc
                              .dispatch(GetMessageList(authState.user.account));
                        } else {
                          print("当前用户未知，无法刷新");
                        }
                      });
                      return result;
                    },
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
