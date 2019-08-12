import 'package:layout_practice/modals/message/Message.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@immutable
abstract class WebSocketEvent {}

class SetWebSocket extends WebSocketEvent {
  WebSocketChannel channel;

  SetWebSocket({@required this.channel});

  @override
  String toString() {
    return "WEBSOCKETEVENT";
  }
}

/**
 * 收到好友消息的操作
 */
class ReceivedMessageWithFriend extends WebSocketEvent {
  Message message;

  ReceivedMessageWithFriend({@required this.message});

  @override
  String toString() {
    return 'RECEIVEDMESSAGEWITHFRIEND';
  }
}

/**
 * 像好友发送消息的事件
 */
class SendMessageToFriend extends WebSocketEvent {
  Message message;
  String friendAccount;

  SendMessageToFriend({@required this.friendAccount, this.message});

  @override
  String toString() {
    return "SENDMESSAGETOFRIEND";
  }
}

class DisPoseSocket extends WebSocketEvent {
  @override
  String toString() {
    return "DISPOSESOCKET";
  }
}
