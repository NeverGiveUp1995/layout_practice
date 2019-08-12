import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:layout_practice/modals/message/MessageHistoryWithFriend.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/consts/FileNames.dart';
import 'package:layout_practice/utils/webSocket/MessageUtils.dart';
import './bloc.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  @override
  WebSocketState get initialState => InitialWebSocketState();

  @override
  Stream<WebSocketState> mapEventToState(
    WebSocketEvent event,
  ) async* {
    /*如果接收到消息时：
    1.首先获取本地与所有用户的消息记录文件中的数据，
          ------如果存在
                首先从该文件中获取与当前用户的聊天记录数据，
                -----如果存在，将最新的数据添加到该消息记录列表中，将最新消息写入缓存文件并且设置更新bloc状态中对应的数据，
                -----如果不存在，创建一个新的消息记录列表，将最新消息写入缓存文件并且更新bloc状态中对应的数据
          ------如果不存在
                创建文件，并且将与当前的用户聊天的数据写入，并且将数据更新到bloc状态中
   */
    if (event is ReceivedMessageWithFriend) {
      print("正在获取聊天记录文件");
      //1.获取与该用户的缓存文件
      File chatHistory = await Utils.getLocalFile(
          'friends_${event.message.sender.account}_${FileNames.chatHistory.toString()}.txt');
      //2.将缓存文件中的数据读取出来并且转换成对应的实体类
      String chatHistoryData = await Utils.readContentFromFile(chatHistory);
      MessageHistoryWithFriend messageHistoryWithFriend =
          MessageHistoryWithFriend.fromJson(json.decode(chatHistoryData));
      //3.将收到的最新数据插入到消息记录中
      messageHistoryWithFriend.messageHistory.insert(0, event.message);
      //4.设置与当前好友的消息记录到状态
      yield MessageHistoryWithFriendState(
        messageHistoryWithFriend: messageHistoryWithFriend,
      );
    }
    /*
     *发送消息：
     *      ----1.将消息存入缓存的同时把当前聊天的好友的聊天记录状态更新
     */
    if (event is SendMessageToFriend) {
      //1.获取与该用户的缓存文件
      File chatHistory = await Utils.getLocalFile(
          'friends_${event.message.sender.account}_${FileNames.chatHistory.toString()}.txt');
      //2.将缓存文件中的数据读取出来并且转换成对应的实体类
      String chatHistoryData = await Utils.readContentFromFile(chatHistory);
      MessageHistoryWithFriend messageHistoryWithFriend =
          MessageHistoryWithFriend.fromJson(json.decode(chatHistoryData));
      //3.将收到的最新数据插入到消息记录中
      messageHistoryWithFriend.messageHistory.insert(0, event.message);
      //4.设置与当前好友的消息记录到状态
      yield MessageHistoryWithFriendState(
        messageHistoryWithFriend: messageHistoryWithFriend,
      );
      //5.将消息发送到服务器
      MessageUtils.sendMessage(event.friendAccount, event.message.content);
    }
    if (event is DisPoseSocket) {
//      关闭socket连接
      if (currentState.channel != null) {
        currentState.channel.sink.close();
      }
    }
  }
}
