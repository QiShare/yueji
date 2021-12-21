import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/event/event_bus.dart';
import 'package:music/manager/user_manager.dart';

class NetUtil {
 static const String BASE_URL = "http://10.0.2.2:8082";

  // static const String BASE_URL = "https://mapi.jiudian.link";

  static Future doGet(String url, {params}) async {
    Dio dio = Dio();

    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = 10000;
    dio.options.responseType = ResponseType.json;

    Map header = Map<String, dynamic>();
    header["os"] = UserManager.instance.os;
    if (UserManager.instance.userModel != null) {
      header["token"] = "${UserManager.instance.userModel.token}";
    }
    dio.options.headers = header;
    Response response;
    response = await dio.get<String>(url, queryParameters: params);

    debugPrint("request params:$url $params ");
    debugPrint("response data : ${response.data.toString()}");

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.data.toString());
      if (result['code'] == 0) {
        return result;
      } else if (result['code'] == 401) {
        /// 登录过期或没有权限
        GlobalEvent.eventBus.fire(TokenExpiredEvent());
        UserManager.instance.logout();
        throw Exception(result['msg']);
      } else {
        throw Exception(result['msg']);
      }
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  static Future doPost(String url, {params}) async {
    Dio dio = Dio();

    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = 5000;

    Map header = Map<String, dynamic>();
    header["os"] = UserManager.instance.os;
    if (UserManager.instance.userModel != null) {
      header["token"] = "${UserManager.instance.userModel.token}";
    }
    dio.options.headers = header;

    Response response;
    if (params == null) {
      response = await dio.post<String>(url, queryParameters: header);
    } else {
      response =
          await dio.post<String>(url, queryParameters: header, data: params);
    }
    debugPrint("request params: $url $params");
    debugPrint("response data: ${response.data.toString()}");

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.data.toString());
      if (result['code'] == 0) {
        return result;
      } else if (result['code'] == 401) {
        /// 登录过期或没有权限
        GlobalEvent.eventBus.fire(TokenExpiredEvent());
        UserManager.instance.logout();
        throw Exception(result['msg']);
      } else {
        throw Exception(result['msg']);
      }
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
