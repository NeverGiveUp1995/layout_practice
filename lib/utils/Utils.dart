import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Utils {
  /**
   * 根据文件名称获取文件
   */
  static Future<File> getLocalFile(String filename) async {
//    String dir = (await getApplicationDocumentsDirectory()).path;
    String dir;
    try {
      dir = (await getExternalStorageDirectory()).path;
    } catch (e) {
      if (e is UnsupportedError) {
        dir = (await getApplicationDocumentsDirectory()).path;
      }
    }
    print("文件目录地址$dir");
    return File('$dir/$filename');
  }

  /**
   * 读取文件内容
   */
  static Future<String> readContentFromFile(File file) async {
    try {
      String content = await (await file).readAsString();
      return content;
    } on FileSystemException {
      CupertinoDialog(
        child: Text('读取文件发生异常!!'),
      );
      print("读取文件发生异常!!");
      return "0";
    }
  }

  /**
   * 将内容写入对应的文件
   */
  static Future<Null> writeContentTofile(File file, String writeContent) async {
    await file.writeAsString(writeContent);
  }

  static Size getScreenSize() {
    Size screenSize = MediaQueryData.fromWindow(window).size;
    return screenSize;
  }

  /**
   * 连接socket，并且获取socket通信的channel对象
   */
  static WebSocketChannel getChannel(String userAccount) {
    return IOWebSocketChannel.connect(
      'ws://192.168.1.32:8080/WebSocketServer/${userAccount}',
//      'ws://192.168.0.123:8080/WebSocketServer/${userAccount}',
//      'ws://192.168.0.112:8080/WebSocketServer/${userAccount}',
    );
  }
}
