import 'package:dio/dio.dart';
import 'package:layout_practice/modals/ServerIp.dart';

class NetServer {
  static Future<Response> request({api, method, params, callback}) async {
    print("loading。。。。");

//    String baseUrl = "http://192.168.1.32";
    String requestUrl =
        await ServerIp(requestType: "http", port: "8080", serverApi: api)
            .getServerIp();
    Dio dio = new Dio();
    //设置请求url
    dio.options.baseUrl = requestUrl;
    // 设置请求超时时长
    dio.options.connectTimeout = 20000;
    Response response;
    if (method is String && method.toLowerCase() == 'get' || method == null) {
      response = await dio.get("$requestUrl", queryParameters: params);
    } else if (method is String && method.toLowerCase() == 'post') {
      response = await dio.post("$requestUrl", queryParameters: params);
    }
    if (callback != null) {
      callback(response);
    }
    return response;
  }
}
