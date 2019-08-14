import 'package:layout_practice/modals/message/MessageHistoryWithFriend.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@immutable
abstract class WebSocketState {
  WebSocketChannel channel;
  MessageHistoryWithFriend messageHistoryWithFriend;
}

class InitialWebSocketState extends WebSocketState {}

/**
 * 设置与当前查看的好友的聊天记录
 */
class MessageHistoryWithFriendState extends WebSocketState {
  MessageHistoryWithFriend messageHistoryWithFriend;

  MessageHistoryWithFriendState({@required this.messageHistoryWithFriend}) {
    print("聊天数据更新了：$messageHistoryWithFriend");
  }
}

class UserWebSocketState extends WebSocketState {
  WebSocketChannel channel;

  UserWebSocketState({@required channel}) {
    this.channel = channel;
    print("正在设置channel$channel");
  }

  @override
  String toString() {
    return 'WEBSOCKETSTATE';
  }
}
