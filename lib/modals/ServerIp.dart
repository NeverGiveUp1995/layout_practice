import 'dart:io';

import 'package:flutter/material.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/consts/FileNames.dart';

class ServerIp {
  String requestType = 'http://';
  String ip = '45.40.198.169'; //线上服务器ip地址
  String port = "8080";
  String serverApi = '';
  String _serverAddress = '';

  ServerIp({@required this.requestType, port, serverApi}) {
    requestType = "$requestType://";
    if (port != null) {
      this.port = port;
    }
    if (serverApi != null) {
      this.serverApi = serverApi;
    }
  }

  Future<String> getServerIp() async {
    File serverIpFile = await Utils.getLocalFile(filename: FileNames.serverIp);
    print("服务器ip地址文件：$serverIpFile");
    String serverIp = await Utils.readContentFromFile(serverIpFile);
    if (serverIp != null) {
      ip = "192.168.${serverIp}";
      _serverAddress = '${requestType}192.168.${serverIp}:8080${serverApi}';
    } else {
      _serverAddress = "${this.requestType}$ip:${this.port}${this.serverApi}";
    }
    return _serverAddress;
  }

  Future<String> getBaseUrl() async {
    await getServerIp();
    return requestType + ip;
  }

  @override
  String toString() {
    return _serverAddress;
  }
}
