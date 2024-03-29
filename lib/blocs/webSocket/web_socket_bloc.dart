import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/systemNotify/bloc.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/modals/message/Message.dart';
import 'package:layout_practice/modals/message/MessageHistoryWithFriend.dart';
import 'package:layout_practice/modals/message/message_list_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/consts/CacheFolderNames.dart';
import 'package:layout_practice/utils/consts/FileNames.dart';
import 'package:layout_practice/utils/request.dart';
import 'package:layout_practice/utils/webSocket/MessageUtils.dart';
import './bloc.dart';
import 'package:layout_practice/utils/Utils.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  @override
  WebSocketState get initialState => InitialWebSocketState();

  /**
   * 从服务器获取当前用户与当前聊天用户的聊天记录，并且将聊天记录添加到bloc状态中
   */
  setChatHistory(BuildContext context, String currentUserAccount,
      String friendAccount, String tipText) async* {
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    Utils.loading(context, true);
    var data = await NetServer.request(
      api: '/message/getChatHistory',
      method: 'post',
      params: {
        "currentUserAccount": currentUserAccount,
        "friendAccount": friendAccount
      },
    );
    print("从服务器获取到聊天记录");
    //1.将聊天记录更新到bloc中，并且将其存入缓存文件
    MessageListEntity messageListEntity =
        MessageListEntity.fromJson(json.decode(data.toString()));

    MessageHistoryWithFriend messageHistoryWithFriend =
        MessageHistoryWithFriend(messageHistory: messageListEntity.data);
    yield MessageHistoryWithFriendState(
      friendAccount: friendAccount,
      messageHistoryWithFriend: messageHistoryWithFriend,
    );
    Utils.loading(context, false);
  }

  @override
  Stream<WebSocketState> mapEventToState(
    WebSocketEvent event,
  ) async* {
    //=============================================================【接受好友信息事件】==========================================================================

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
      MessageBloc messageBloc = BlocProvider.of<MessageBloc>(event.context);
      SystemNotifyBloc systemNotifyBloc =
          BlocProvider.of<SystemNotifyBloc>(event.context);
      AuthBloc authBloc = BlocProvider.of<AuthBloc>(event.context);

      MessageHistoryWithFriend messageHistoryWithFriend =
          MessageHistoryWithFriend(messageHistory: List<Message>());
      User receiver = event.message.receiver;
      User sender = event.message.sender;
      //1.获取与该用户的缓存文件
      File chatHistoryFile;
      //如果消息类型是【私人消息：msgType = 1】
      switch (event.message.msgType) {
        case "1": //【系统消息】
          chatHistoryFile = await Utils.getLocalFile(
            currentLoginUserAccount: receiver.account,
            folderName: '${CacheFolderNames.system}/${sender.account}',
            filename: '${FileNames.chatHistory}',
          );
          systemNotifyBloc.dispatch(GetSystemNotify(
              context: event.context,
              userAccount: authBloc.currentState.user.account));
          break;
        case "2": //【私人消息】
          chatHistoryFile = await Utils.getLocalFile(
            currentLoginUserAccount: receiver.account,
            folderName: '${CacheFolderNames.friends}/${sender.account}',
            filename: '${FileNames.chatHistory}',
          );
          break;
        case "3": //【群消息】
          chatHistoryFile = await Utils.getLocalFile(
            currentLoginUserAccount: receiver.account,
            folderName: '${CacheFolderNames.groups}/${sender.account}',
            filename: '${FileNames.chatHistory}',
          );
      }

      //2.将缓存文件中的数据读取出来并且转换成对应的实体类
      String chatHistoryData = await Utils.readContentFromFile(chatHistoryFile);
      if (chatHistoryData != null) {
        try {
          messageHistoryWithFriend =
              MessageHistoryWithFriend.fromJson(json.decode(chatHistoryData));
        } catch (e) {
          print("从json数据转换到实体类出错-----与当前好友还没有任何聊天记录或者聊天记录数据被破坏");
        }
      }
      //3.将收到的最新数据插入到消息记录中
      messageHistoryWithFriend.messageHistory.insert(0, event.message);
      //将新消息简略略信息放在消息列表页中
      messageBloc.dispatch(AddNewMessageEvent(message: event.message));

      try {
        Utils.writeContentTofile(
            chatHistoryFile, messageHistoryWithFriend.toString());
      } catch (e) {
        print("写入文件出错-----数据写入文件的时候出现了异常");
      } //判断程序是否处于后台运行的状态，如果是后台运行，则通过通知栏消息，给出提示，如果不是，则不给出
      //4.设置与当前好友的消息记录到状态
      yield MessageHistoryWithFriendState(
        //注意：因为此事件是  好友--》发送消息--》自己，所以此时，好友作为sender，自己作为receiver
        friendAccount: sender.account,
        messageHistoryWithFriend: messageHistoryWithFriend,
      );
    }

    //=============================================================【发送聊天信息的事件】==========================================================================

    /*
     *发送消息给朋友或者是群组：
     *      ----1.将消息存入缓存的同时把当前聊天的好友的聊天记录状态更新
     */
    if (event is SendMessageToFriend) {
      MessageBloc messageBloc = BlocProvider.of<MessageBloc>(event.context);
      MessageHistoryWithFriend messageHistoryWithFriend =
          MessageHistoryWithFriend(messageHistory: List<Message>());
      //1.获取与该用户的缓存文件
      File chatHistoryFile = await Utils.getLocalFile(
        currentLoginUserAccount: event.message.sender.account,
        folderName:
            '${CacheFolderNames.friends}/${event.message.receiver.account}',
        filename: '${FileNames.chatHistory}',
      );
      //2.将缓存文件中的数据读取出来并且转换成对应的实体类
      String chatHistoryData = await Utils.readContentFromFile(chatHistoryFile);
      if (chatHistoryData != null) {
        try {
          print("解码出来的json数据：${json.decode(chatHistoryData)}");
          messageHistoryWithFriend =
              MessageHistoryWithFriend.fromJson(json.decode(chatHistoryData));
        } catch (e) {
          print("从json数据转换到实体类出错-----与当前好友还没有任何聊天记录或者聊天记录数据被破坏");
        }
      }
      //3.将收到的最新数据插入到消息记录中
      messageHistoryWithFriend.messageHistory.insert(0, event.message);
      Utils.writeContentTofile(
          chatHistoryFile, messageHistoryWithFriend.toString());
      //将新消息简略略信息放在消息列表页中
      messageBloc.dispatch(AddNewMessageEvent(message: event.message));
      //4.设置与当前好友的消息记录到状态
      yield MessageHistoryWithFriendState(
        //注意：因为此事件是  自己--》发送消息--》好友，所以此时，好友作为receiver，自己作为sender
        friendAccount: event.message.receiver.account,
        messageHistoryWithFriend: messageHistoryWithFriend,
      );
      //5.将消息发送到服务器
      MessageUtils.sendMessage(
        event.message.receiver.account,
        event.message.content,
        event.message.msgType,
      );
    }
    //=============================================================【初始化聊天记录事件】==========================================================================
    if (event is InitChatHisStory) {
      //1.判断当前用户与当前的好友的聊天记录数据是否在bloc中存在，如果不存在，则从文件中读取，如果文件中也不存在，则发送请求到服务器拉取两人聊天记录并初始化
      String currentUserAccount = event.currentUserAccount;
      String friendAccount = event.friendAccount;
      print(
          "======================================${currentState.messageHistoryWithFriends}");
      if (currentState.messageHistoryWithFriends == null ||
          (currentState.messageHistoryWithFriends != null &&
              currentState.messageHistoryWithFriends[friendAccount] == null)) {
        //------1.1，获取当前聊天两人的聊天记录文件
        File chatHistoryFile = await Utils.getLocalFile(
          currentLoginUserAccount: currentUserAccount,
          folderName: "${CacheFolderNames.friends}/${friendAccount}",
          filename: FileNames.chatHistory,
        );
        String chatContent = await Utils.readContentFromFile(chatHistoryFile);

        if (chatContent != null) {
          MessageHistoryWithFriend messageHistoryWithFriend;
          try {
            messageHistoryWithFriend =
                MessageHistoryWithFriend.fromJson(json.decode(chatContent));
            //更新bloc中的聊天数据
            yield MessageHistoryWithFriendState(
              friendAccount: friendAccount,
              messageHistoryWithFriend: messageHistoryWithFriend,
            );
          } catch (e) {
            Utils.loading(event.context, true);
            var data = await NetServer.request(
              api: '/message/getChatHistory',
              method: 'post',
              params: {
                "currentUserAccount": currentUserAccount,
                "friendAccount": friendAccount
              },
            );
            print("从服务器获取到聊天记录");
            //1.将聊天记录更新到bloc中，并且将其存入缓存文件
            MessageListEntity messageListEntity =
                MessageListEntity.fromJson(json.decode(data.toString()));

            MessageHistoryWithFriend messageHistoryWithFriend =
                MessageHistoryWithFriend(
                    messageHistory: messageListEntity.data);
            yield MessageHistoryWithFriendState(
              friendAccount: friendAccount,
              messageHistoryWithFriend: messageHistoryWithFriend,
            );
            try {
              Utils.writeContentTofile(
                  chatHistoryFile, messageHistoryWithFriend.toString());
            } catch (e) {
              print("写入文件出错-----数据写入文件的时候出现了异常");
            }
            Utils.loading(event.context, false);
          }
        } else {
          Utils.loading(event.context, true);
          var data = await NetServer.request(
            api: '/message/getChatHistory',
            method: 'post',
            params: {
              "currentUserAccount": currentUserAccount,
              "friendAccount": friendAccount
            },
          );
          print("从服务器获取到聊天记录");
          //1.将聊天记录更新到bloc中，并且将其存入缓存文件
          MessageListEntity messageListEntity =
              MessageListEntity.fromJson(json.decode(data.toString()));

          MessageHistoryWithFriend messageHistoryWithFriend =
              MessageHistoryWithFriend(messageHistory: messageListEntity.data);
          try {
            Utils.writeContentTofile(
                chatHistoryFile, messageHistoryWithFriend.toString());
          } catch (e) {
            print("写入文件出错-----数据写入文件的时候出现了异常");
          }
          yield MessageHistoryWithFriendState(
            friendAccount: friendAccount,
            messageHistoryWithFriend: messageHistoryWithFriend,
          );
          Utils.loading(event.context, false);
        }
      } else {
        print("bloc中存在与当前好友的聊天记录，不用发送请求");
      }
    }
  }
}
