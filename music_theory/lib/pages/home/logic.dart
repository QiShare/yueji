import 'package:get/get.dart';
import 'package:music/net/api_client.dart';
import 'package:music/pages/home/model/article_list_model.dart';
import 'package:music/pages/home/model/home_model.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final state = HomeState();

  @override
  void onReady() {
    super.onReady();
    refresh();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> home() async {
    try {
      HomeModel model = await ApiClient.home();
      state.banners.clear();
      state.banners.addAll(model.banners);
    } catch (e) {}
  }

  Future<void> refresh() async {
    home();
    try {
      state.currentPage = 0;
      ArticleListModel model =
          await ApiClient.getArticleList(state.currentPage);
      print("refresh $model");
      if (model.articles.length > 0) {
        state.currentPage++;
        state.articles.clear();
        state.articles.addAll(model.articles.obs);
      }
    } catch (e) {
      print("refresh ${e.toString()}");
      Get.snackbar("提示", "请求失败，请重试");
    }
  }

  // todo 数据少暂时不用加载更多了
  Future<void> loadMore() async {
    try {
      ArticleListModel model =
          await ApiClient.getArticleList(state.currentPage);
      if (model.articles.length > 0) {
        state.currentPage++;
        state.articles.addAll(model.articles.obs);
      } else {
//        state.controller.finishLoad(noMore: true);
      }
    } catch (e) {
      Get.snackbar("提示", "请求失败，请重试");
    }
  }
}
