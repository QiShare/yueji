import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/component/dialog.dart';
import 'package:music/event/event_bus.dart';
import 'package:music/manager/user_manager.dart';
import 'package:music/utils/color_utils.dart';

/// 设置
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: CommonAppBar(
        title: Text(
          "设置",
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text("通用"),
              ),
              InkWell(
                onTap: () => CustomDialog.showCustomDialog(
                  context,
                  title: Text("确认退出吗"),
                  positiveText: Text("确认"),
                  negativeText: Text("取消"),
                  onPositivePressed: () async {
                    await UserManager.instance.logout();
                    Get.until((route) => route.isFirst);
                    GlobalEvent.eventBus.fire(LogoutEvent());
                  },
                  onNegativePressed: () {
                    Get.back();
                  },
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "退出登录",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
