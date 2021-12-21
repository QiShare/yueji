import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music/net/api_client.dart';
import 'package:music/pages/article_detail/model/article_detail_model.dart';

import 'state.dart';

class ArticleDetailLogic extends GetxController {
  final int id;
  final state = ArticleDetailState();

  ArticleDetailLogic(this.id);

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  fetchData() async {
    try {
      EasyLoading.show();
      ArticleDetailModel model = await ApiClient.getArticleDetail(id);
      state.content.value = model.articleDetail;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("加载失败", e.toString());
    }
  }

  addToFav(int id) {}
}
