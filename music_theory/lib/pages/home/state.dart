import 'package:get/get.dart';
import 'package:music/pages/home/model/article_list_model.dart';

import 'model/home_model.dart';

class HomeState {
  RxList<Articles> articles;
  int currentPage = 0;
  RxList<Banners> banners;

  HomeState() {
    articles = List<Articles>().obs;
    banners = List<Banners>().obs;
  }
}
