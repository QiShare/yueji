import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:music/net/api_client.dart';
import 'package:package_info/package_info.dart';
import 'package:store_redirect/store_redirect.dart';

import 'model/check_update_model.dart';
import 'state.dart';

class AboutLogic extends GetxController {
  final state = AboutState();

  @override
  void onReady() {
    super.onReady();
    getLocalVersion();
  }

  Future<void> checkUpdate() async {
    try {
      CheckUpdateModel model = await ApiClient.checkUpdate();
      final PackageInfo info = await PackageInfo.fromPlatform();

      if (Platform.isAndroid) {
        if (model.versionCode > int.parse(info.buildNumber)) {
          ///有新版本
          Get.snackbar("提示", "请前往官网下载最新版本");
        } else {
          Get.snackbar("提示", "已经是最新版本");
        }
      } else {
        if (Platform.isIOS) {
          if (model.versionCode > int.parse(info.buildNumber)) {
            ///有新版本
            StoreRedirect.redirect(
                androidAppId: "link.jiudian.music", iOSAppId: "1561811916");
          } else {
            Get.snackbar("提示", "已经是最新版本");
          }
        }
      }
    } catch (e) {
      Get.snackbar("提示", "请求失败，请重试");
    }
  }

  clearCache() async {
    await DefaultCacheManager().emptyCache();
    Get.snackbar("提示", "已清除缓存");
  }

  /// 获取当前版本
  void getLocalVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    state.version.value = info.version;
  }
}
