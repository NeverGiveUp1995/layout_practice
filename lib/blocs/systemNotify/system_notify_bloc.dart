import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:layout_practice/blocs/systemNotify/bloc.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/message/message_list_entity.dart';
import 'package:layout_practice/utils/request.dart';

class SystemNotifyBloc extends Bloc<SystemNotifyEvent, SystemNotifyState> {
  @override
  SystemNotifyState get initialState => InitialSystemNotifyState();

  @override
  Stream<SystemNotifyState> mapEventToState(
    SystemNotifyEvent event,
  ) async* {
    if (event is GetSystemNotify) {
      Response response = await NetServer.request(
        api: '/user/getMessages',
        method: 'post',
        params: {
          "userAccount": event.userAccount,
          "msgType": "1",
          "count": -1,
        },
      );
      MessageListEntity messageListEntity = MessageListEntity.fromJson(
        json.decode(
          response.toString(),
        ),
      );

      if (messageListEntity.data != null) {
        messageListEntity.data
            .sort((left, right) => left.messageId.compareTo(right.messageId));
        yield MessageState(messageList: messageListEntity.data);
      }
    }
  }
}
