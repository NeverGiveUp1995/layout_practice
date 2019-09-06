import 'package:layout_practice/modals/friend/groups_entity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupState {
  List<GroupsData> get groups => null;
}

class InitialGroupState extends GroupState {}

//当前的好友列表状态
class Groups extends GroupState {
  List<GroupsData> groups;

  Groups({@required this.groups});
}
