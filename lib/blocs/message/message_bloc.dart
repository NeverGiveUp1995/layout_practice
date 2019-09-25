import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/message/message_list_entity.dart';
import 'package:layout_practice/utils/request.dart';
import './bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  @override
  MessageState get initialState => InitialMessageState();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is GetMessageList) {
      print("准备发送请求获取消息列表");
      Response response = await NetServer.request(
        api: '/user/getMessages',
        method: 'post',
        params: {"userAccount": event.userAccount, "count": -1},
      );
      MessageListEntity messageListEntity = MessageListEntity.fromJson(
        json.decode(
          response.toString(),
        ),
      );
      print("获取到消息列表：${messageListEntity.data}");
      if (messageListEntity.data != null) {
        yield MessageListState(messageList: messageListEntity.data);
      }
      //更新最新的消息列表到本地缓存
      //暂时先不写
    }
    //收到新消息时，添加新消息到列表
    if (event is AddNewMessageEvent) {
      print("正在更新聊天列表");
      List<Message> messageList = currentState.messageList ?? [];
      int index = -1;
      //遍历当前列表，查看是否当前消息项是否已经存在，如果存在，删除原来的，将最新的放在第一个，如果不存在，直接添加最新的在前面
      for (int i = 0; i < messageList.length; i++) {
        if (event.message.msgType != 1) {
          if (messageList[i].conversationId == event.message.conversationId) {
            index = i;
            break;
          }
        } else {
          if (messageList[i].msgType == 1) {
            index = i;
            break;
          }
        }
      }
      if (index != -1) {
        messageList.removeAt(index);
      }
      messageList.insert(0, event.message);
      //如果列表大于100 条了，删除最后面一条(最多存放100条)
      if (messageList.length > 100) {
        messageList.removeLast();
      }
      //更新最新的消息列表到bloc中，并且存储到本地缓存
      yield MessageListState(messageList: messageList);
      //暂时先不写
    }
  }
}
