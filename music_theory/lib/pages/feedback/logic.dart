import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music/net/api_client.dart';

import 'state.dart';

class FeedbackLogic extends GetxController {
  final state = FeedbackState();

  submit() async {
    String content = state.textController.text.trim();
    if (content.isEmpty) {
      Get.snackbar("提示", "内容不能为空");
      return;
    }
    try {
      EasyLoading.show();
      await ApiClient.feedback(content);
      EasyLoading.dismiss();
      Get.back();
      Get.snackbar("提示", "反馈成功");
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.dismiss();
      Get.snackbar("加载失败", e.toString());
    }
  }
}
