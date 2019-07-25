import 'package:dio/dio.dart';

class NetServer {
  static Future<Response> request({api, method, params, callback}) async {
    print("loading。。。。");
//    String baseUrl = "http://192.168.0.112";
//    String baseUrl = "http://192.168.1.19";
    String baseUrl = "http://192.168.1.29";
    int port = 8080;
    Dio dio = new Dio();
    //设置请求url
    dio.options.baseUrl = baseUrl;
    // 设置请求超时时长
    dio.options.connectTimeout = 20000;
    Response response;
    if (method is String && method.toLowerCase() == 'get' || method == null) {
      response = await dio.get("$baseUrl:$port$api", queryParameters: params);
    } else if (method is String && method.toLowerCase() == 'post') {
      response = await dio.post("$baseUrl:$port$api", queryParameters: params);
    }
    callback(response);
    return response;
  }
}
