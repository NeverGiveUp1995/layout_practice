import 'package:layout_practice/modals/message/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageState {
  List<Message> messageList;
}

class InitialMessageState extends MessageState {}

class MessageListState extends MessageState {
  List<Message> messageList;

  MessageListState({@required messageList}) {
    this.messageList = messageList;
  }

  @override
  String toString() {
    return 'messageList$messageList';
  }
}
