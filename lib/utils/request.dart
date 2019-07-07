import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class NetServer {
  static String serverHttp = "http://localhost";
  static int port = 8080;
  static Dio dio = new Dio();

  static request({url, callback}) async {
    Response response;
    response = await dio.get(url);
    callback(response);
    return response;
  }
}
