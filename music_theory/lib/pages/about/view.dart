import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/utils/color_utils.dart';

import 'logic.dart';
import 'state.dart';

/// 关于页面
class AboutPage extends StatelessWidget {
  final AboutLogic logic = Get.put(AboutLogic());
  final AboutState state = Get.find<AboutLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAppInfo(),
                _buildUpgrade(),
              ],
            ),
          ),
          _buildHeader(),
        ],
      ),
    );
  }

  /// 应用信息
  _buildAppInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        Image.asset(
          "assets/images/icon_launcher.png",
          width: 80,
          height: 80,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "乐记",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorUtils.dark_blue,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "音为爱 所以乐",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ColorUtils.dark_blue,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Obx(
          () => Text(
            "版本号：${state.version}",
            style: TextStyle(
              fontSize: 12,
              color: ColorUtils.dark_blue,
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }

  /// 应用升级
  _buildUpgrade() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => logic.checkUpdate(),
          child: Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "检查更新",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorUtils.dark_blue,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0.5,
          color: ColorUtils.grey,
        ),
        InkWell(
          onTap: () => logic.clearCache(),
          child: Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "清除缓存",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorUtils.dark_blue,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildHeader() {
    return SafeArea(
      top: true,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}
