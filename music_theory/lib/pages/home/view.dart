import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/component/music_refresh_header.dart';
import 'package:music/pages/article_detail/view.dart';
import 'package:music/pages/feedback/view.dart';
import 'package:music/pages/piano/piano_page.dart';
import 'package:music/utils/color_utils.dart';

import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        leading: Center(
          child: Image.asset(
            "assets/images/icon_launcher_round.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "乐记",
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: EasyRefresh.custom(
        header: MusicRefreshHeader(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 220,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Obx(
                        () => CarouselSlider(
                          items: state.banners
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 180,
                                      child: AspectRatio(
                                        aspectRatio: 15 / 6,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://ftp.bmp.ovh/imgs/2021/04/f2f6d923668e68ee.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              height: 180,
                              autoPlayInterval: Duration(seconds: 3),
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {}),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 55,
                          height: 55,
                          child: InkWell(
                            onTap: () => Get.to(PianoPage()),
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.queue_music_sharp,
                                  color: ColorUtils.primary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 55,
                          height: 55,
                          child: InkWell(
                            onTap: () => Get.to(FeedbackPage()),
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.send,
                                  color: ColorUtils.primary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => Get.to(ArticleDetailPage(
                            id: state.articles[index].id,
                            title: state.articles[index].title,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: const EdgeInsets.only(right: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: index % 2 == 0
                                          ? Color(0xffeb763c)
                                          : Color(0xff459b95),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.articles[index].title,
                                        style: TextStyle(
                                          color: Color(0xff393939),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                  );
                },
                childCount: state.articles.length,
              ),
            ),
          ),
        ],
        onRefresh: logic.refresh,
      ),
    );
  }
}
