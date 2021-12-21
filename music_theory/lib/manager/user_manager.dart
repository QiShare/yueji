import 'dart:convert';
import 'dart:io';

import 'package:music/pages/login/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用户管理
/// 登录、退出
class UserManager {
  factory UserManager() => _getInstance();

  static UserManager get instance => _getInstance();
  static UserManager _instance;

  LoginModel userModel;
  String os = "";

  UserManager._internal();

  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = new UserManager._internal();
    }
    return _instance;
  }

  Future<void> init() async {
    if (userModel != null) {
      return;
    }
    var sp = await SharedPreferences.getInstance();
    if (sp.getString("login_model") != null) {
      userModel = LoginModel.fromJson(jsonDecode(sp.getString("login_model")));
    }

    if (Platform.isAndroid) {
      os = "android";
    } else if (Platform.isIOS) {
      os = "ios";
    }
  }

  bool isLogin() {
    return userModel != null && userModel.token != null;
  }

  Future<void> logout() async {
    userModel = null;
    var sp = await SharedPreferences.getInstance();
    sp.setString("login_model", null);
  }
}
