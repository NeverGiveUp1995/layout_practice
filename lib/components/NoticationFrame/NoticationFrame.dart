import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:layout_practice/blocs/notice/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:layout_practice/views/Chat/Chat.dart';
import 'package:path_provider/path_provider.dart'; //引入通知插件库

class NotificationFrame extends StatefulWidget {
  Widget child;
  String msgType; //消息类型

  NotificationFrame({this.child});

  @override
  State<StatefulWidget> createState() {
    return _NotificationFrameState();
  }
}

class _NotificationFrameState extends State<NotificationFrame> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NoticeBloc noticeBloc;
  WebSocketBloc webSocketBloc;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    //创建通知对象
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              String senderAccount = payload.split('-')[0];
              String senderName = payload.split('-')[1];
              await Navigator.push(
                _context,
                new MaterialPageRoute(
                  builder: (context) => Chat(
                    receiverAccount: senderAccount,
                    title: senderName,
                    msgType: widget.msgType,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    //payload 可作为通知的一个标记，区分点击的通知。
    if (payload != null) {
      String senderAccount = payload.split('-')[0];
      String senderName = payload.split('-')[1];
//      print(context);
      Navigator.push(
        _context,
        new MaterialPageRoute(
          builder: (context) => Chat(
            receiverAccount: senderAccount,
            title: senderName,
            msgType: widget.msgType,
          ),
        ),
      );
    }
  }

  Future _showNotification(int id, String title, String content, String imgSrc,
      String payload) async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin
        .show(id, title, content, platformChannelSpecifics, payload: payload);
    noticeBloc.dispatch(PublishNotice(isShow: false));
  }

  @override
  Widget build(BuildContext context) {
    noticeBloc = BlocProvider.of<NoticeBloc>(context);
    _context = context;
    return BlocBuilder(
      bloc: noticeBloc,
      builder: (BuildContext context, NoticeState currentState) {
        if (currentState.isShow != null &&
            currentState.isShow &&
            currentState.noticeId != null) {
          int noticeId = currentState.noticeId;
          String title = '您有一条${currentState.senderName}的消息未查看：';
          String imgSrc = currentState.imgSrc;
          String content = currentState.content;
          String senderName = currentState.senderName;
          String senderAccount = currentState.senderAccount;
          _showNotification(
              noticeId, title, content, '', '$senderAccount-$senderName');
        }
        return widget.child;
      },
    );
  }
}
