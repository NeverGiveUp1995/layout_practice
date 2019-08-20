import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Utils {
  /**
   * 根据文件名称获取文件
   */
  static Future<File> getLocalFile(
      {String currentLoginUserAccount,
      String folderName,
      @required String filename}) async {
    String dir;
    print(currentLoginUserAccount);
    try {
      dir = (await getExternalStorageDirectory()).path;
    } catch (e) {
      if (e is UnsupportedError) {
        dir = (await getApplicationDocumentsDirectory()).path;
      }
    }
    //创建对应的文件夹
    if (folderName != null) {
      await Directory(
              "$dir/${currentLoginUserAccount != null ? "currentLoginUserAccount/" : ''}/$folderName")
          .create(recursive: true);
      print(
          "文件目录地址$dir/${currentLoginUserAccount != null ? "currentLoginUserAccount/" : ''}/$folderName/$filename");
    }
    File file = await File(
        '$dir/${currentLoginUserAccount != null ? "currentLoginUserAccount/" : ''}${folderName != null ? "$folderName/" : ""}$filename');
    print("创建的文件：$file");
    return file;
  }

  /**
   * 读取文件内容
   */
  static Future<String> readContentFromFile(File file) async {
    print("读取文件方法\n              ========>传入的文件：${file}");
    try {
      String content = await (await file).readAsString();
      print("\n读取文件方法：读取数据：$content\n");
      return content;
    } on FileSystemException {
      CupertinoDialog(
        child: Text('读取文件发生异常!!'),
      );
      print("读取文件发生异常!!");
      return null;
    }
  }

  /**
   * 将内容写入对应的文件
   */
  static Future<Null> writeContentTofile(File file, String writeContent) async {
    print("即将将数据写入文件。。。。：$writeContent");
    await file.writeAsString(writeContent);
  }

  static Size getScreenSize() {
    Size screenSize = MediaQueryData.fromWindow(window).size;
    return screenSize;
  }

  /**
   * 延时器方法
   */
  static void setTimeOut(Function callback, int duration) {
    Duration duration1 = Duration(milliseconds: duration);
    Timer(duration1, callback);
  }

  /**
   * 开启/关闭loading组件
   */
  static void loading(BuildContext context, bool openState) {
    if (openState) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  static void showTip(
      {@required BuildContext context,
      @required String tipText,
      int duration,
      Function callback}) {
    print("提示信息：$tipText");
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return UnconstrainedBox(
          child: Container(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Color.fromRGBO(50, 50, 50, 0.8),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(
                    tipText != null || tipText != '' ? tipText : "没有任何提示信息！",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    setTimeOut(() {
      Navigator.of(context).pop();
      if (callback != null) {
        callback();
      }
    }, duration != null ? duration : 500);
  }
}
