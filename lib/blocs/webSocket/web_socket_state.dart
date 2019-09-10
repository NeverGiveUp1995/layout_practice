import 'package:layout_practice/modals/message/MessageHistoryWithFriend.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WebSocketState {
  Map<String, MessageHistoryWithFriend> messageHistoryWithFriends;
}

class InitialWebSocketState extends WebSocketState {}

/**
 * 设置与当前查看的好友的聊天记录
 */
class MessageHistoryWithFriendState extends WebSocketState {
  Map<String, MessageHistoryWithFriend> messageHistoryWithFriends =
      new Map<String, MessageHistoryWithFriend>();

  MessageHistoryWithFriendState(
      {@required messageHistoryWithFriend, @required friendAccount}) {
    messageHistoryWithFriends[friendAccount] = messageHistoryWithFriend;
  }
}
