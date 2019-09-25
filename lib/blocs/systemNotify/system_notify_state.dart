import 'package:layout_practice/modals/message/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SystemNotifyState {
  List<Message> messageList;
}

class InitialSystemNotifyState extends SystemNotifyState {}

class MessageState extends SystemNotifyState {
  List<Message> messageList;

  MessageState({@required this.messageList});
}
