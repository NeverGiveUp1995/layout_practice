import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/message/single_message_result_entity.dart';
import 'package:provider/provider.dart';

class MessageUtils {
  static WebSocket _webSocket;

  static void connect(String userAccount, BuildContext context) {
    print(
        '\n\n\n===============================【正在创建与服务器的连接。。。】========================================');
    Future<WebSocket> futureWebSocket = WebSocket.connect(
        'ws://192.168.1.32:8080/WebSocketServer/${userAccount}'); // Api.WS_URL 为服务器端的 websocket 服务
    futureWebSocket.then((WebSocket ws) {
      _webSocket = ws;
      _webSocket.readyState;
      /**
       * 订阅服务器发送的消息
       */
      void onData(dynamic data) {
        print("收到服务器发来的消息:$data");
        WebSocketBloc webSocketBloc = Provider.of<WebSocketBloc>(context);
        SingleMessageResultEntity singleMessageResultEntity =
            SingleMessageResultEntity.fromJson(json.decode(data));
        Message message = singleMessageResultEntity.data;
        if (message != null) {
          //更新数据
          SingleMessageResultEntity singleMessageResultEntity =
              SingleMessageResultEntity.fromJson(json.decode(data));
          Message message = singleMessageResultEntity.data;
          WebSocketBloc webSocketBloc = Provider.of<WebSocketBloc>(context);
          webSocketBloc.dispatch(ReceivedMessageWithFriend(message: message));
        }
        webSocketBloc.dispatch(ReceivedMessageWithFriend(message: message));
      }

      _webSocket.listen(
        onData,
        onError: (a) => print("接收服务器消息发生错误！"),
        onDone: () => print("done"),
      );
    });
  }

  static void closeSocket() {
    _webSocket.close();
  }

  /**
   * // 向服务器发送消息
   * @param:receiverAccount,告诉服务器将该消息发送给哪个用户
   */
  static void sendMessage(String receiverAccount, String message) {
    _webSocket.add('${receiverAccount}-${message}');
  }
//
//  // 手机状态栏弹出推送的消息
//  static void _createNotification(String title, String content) async {
//    await LocalNotifications.createNotification(
//      id: _id,
//      title: title,
//      content: content,
//      onNotificationClick: NotificationAction(
//          actionText: "some action",
//          callback: _onNotificationClick,
//          payload: "接收成功！"),
//    );
//  }
//
//  static _onNotificationClick(String payload) {
//    LocalNotifications.removeNotification(_id);
//    sendMessage("消息已被阅读");
//  }
}