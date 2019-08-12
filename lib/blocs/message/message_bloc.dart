import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
        params: {
          "userAccount": event.userAccount,
        },
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
    }
    if (event is ClearMessageState) {
      yield MessageListState(messageList: null);
    }
  }
}
