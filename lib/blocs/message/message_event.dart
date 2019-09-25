import 'package:layout_practice/modals/message/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageEvent {}

class GetMessageList extends MessageEvent {
  String userAccount;

  GetMessageList({@required this.userAccount});

  @override
  String toString() {
    return "GetMessageList";
  }
}

class ClearMessageStateEvent extends MessageEvent {
  @override
  String toString() {
    return 'ClearMessageList';
  }
}

class AddNewMessageEvent extends MessageEvent {
  Message message;

  AddNewMessageEvent({this.message});

  @override
  String toString() {
    return "AddNewMessageEvent";
  }
}
