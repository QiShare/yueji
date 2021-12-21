import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music/manager/user_manager.dart';
import 'package:music/net/api_client.dart';
import 'package:music/pages/login/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/login_model.dart';

class LoginLogic extends GetxController {
  final String email;
  final state = LoginState();

  LoginLogic(this.email);

  login() async {
    String code = state.codeController.text.trim();
    if (code.isEmpty) {
      Get.snackbar("提示", "验证码不能为空");
      return;
    }
    EasyLoading.show();
    try {
      EasyLoading.dismiss();
      LoginModel value = await ApiClient.login(email, code);
      var sp = await SharedPreferences.getInstance();
      sp.setString("login_model", json.encode(value));
      UserManager.instance.userModel = value;
      Get.until((route) => route.isFirst);
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("提示", "登录失败");
    }
  }
}
