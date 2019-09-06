import 'package:meta/meta.dart';

@immutable
abstract class GroupEvent {}

//获取分组列表的事件
class GetGroups extends GroupEvent {
  String userAccount;

  GetGroups({@required this.userAccount});

  @override
  String toString() {
    return "GETGROUPS";
  }
}
