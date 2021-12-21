import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music/net/api_client.dart';
import 'package:music/pages/login/view.dart';

import 'state.dart';

class SendEmailLogic extends GetxController {
  final state = SendEmailState();

  sendEmail() async {
    String email = state.emailEditController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("提示", "邮箱不能为空");
      return;
    }
    EasyLoading.show();
    try {
      await ApiClient.sendEmail(email);
      EasyLoading.dismiss();
      Get.to(LoginPage(), arguments: email);
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("提示", e.message ?? "发送验证码失败");
    }
  }
}
