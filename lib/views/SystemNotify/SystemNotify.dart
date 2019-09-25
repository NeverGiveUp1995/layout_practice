/**
 * 系统通知处理页
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/systemNotify/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/message/Message.dart';

class SystemNotify extends StatefulWidget {
  @override
  _SystemNotifyState createState() => _SystemNotifyState();
}

class _SystemNotifyState extends State<SystemNotify> {
  AuthBloc authBloc;
  SystemNotifyBloc systemNotifyBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    systemNotifyBloc = BlocProvider.of<SystemNotifyBloc>(context);
    return BlocBuilder(
      bloc: authBloc,
      builder: (BuildContext context, AuthState authState) {
        return BlocBuilder(
          bloc: systemNotifyBloc,
          builder: (BuildContext context, SystemNotifyState systemNotifyState) {
            List<Message> messageList = systemNotifyState.messageList ?? [];
            if (systemNotifyState.messageList == null) {
              systemNotifyBloc.dispatch(GetSystemNotify(
                  context: context, userAccount: authState.user.account));
            }
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: BackBtn(),
                title: Text(
                  "系统通知",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                centerTitle: true,
              ),
              body: Container(
                child: ListView(
                  children: messageList
                      .map((message) => Container(
                            height: 220,
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xdddfdfdf),
                                  offset: Offset(0, 2),
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                //头像显示区域
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Header(
                                              width: 80,
                                              height: 80,
                                              imgSrc: message.sender.headerImg,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                "${message.sender != null ? message.sender.nickName ?? "未知名称" : ""}\n${message.sender != null ? message.sender.account ?? "未知名称" : ""}",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text("请求加为好友"),
                                            ),
                                            Container(
                                              width: 60,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                top: BorderSide(
                                                    color: Colors.black38,
                                                    style: BorderStyle.solid),
                                                bottom: BorderSide(
                                                    color: Colors.black38,
                                                    style: BorderStyle.solid),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Header(
                                              width: 80,
                                              height: 80,
                                              imgSrc:
                                                  message.receiver.headerImg,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                "${message.receiver != null ? message.receiver.nickName ?? "未知名称" : ""}\n${message.receiver != null ? message.receiver.account ?? "未知名称" : ""}",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //操作按钮
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                                color: Colors.black12),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            "残忍拒绝",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border.all(
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                                color: Colors.black12),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            "同意",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
