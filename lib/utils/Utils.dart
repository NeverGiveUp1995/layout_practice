import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Utils {
  /**
   * 根据文件名称获取文件
   */
  static Future<File> getLocalFile(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("文件路径====>$dir");
    return File('$dir/$filename');
  }

  /**
   * 读取文件内容
   */
  static Future<String> readContentFromFile(Future<File> file) async {
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
  static Future<Null> writeContentTofile(
      Future<File> file, String writeContent) async {
    await (await file).writeAsString(writeContent);
  }
}
