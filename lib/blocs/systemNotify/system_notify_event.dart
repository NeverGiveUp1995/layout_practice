import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SystemNotifyEvent {}

class GetSystemNotify extends SystemNotifyEvent {
  BuildContext context;
  String userAccount;

  GetSystemNotify({@required this.context, @required this.userAccount});

  @override
  String toString() {
    return "GetSystemNotify";
  }
}
