import 'package:meta/meta.dart';

@immutable
abstract class MessageEvent {}

class GetMessageList extends MessageEvent {
  String userAccount;

  GetMessageList(@required this.userAccount);

  @override
  String toString() {
    return "GetMessageList";
  }
}

class ClearMessageState extends MessageEvent {
  @override
  String toString() {
    return 'ClearMessageList';
  }
}
