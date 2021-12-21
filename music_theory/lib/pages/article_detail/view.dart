import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/utils/color_utils.dart';

import 'logic.dart';
import 'state.dart';

/// 乐理文章详情
class ArticleDetailPage extends StatelessWidget {
  final int id;
  final String title;

  const ArticleDetailPage({Key key, this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticleDetailLogic logic = Get.put(ArticleDetailLogic(id));
    final ArticleDetailState state = Get.find<ArticleDetailLogic>().state;

    return Scaffold(
      appBar: CommonAppBar(
        title: Text(
          title,
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: Obx(
        () => Markdown(
          onTapLink: (url) {},
          styleSheet: MarkdownStyleSheet.fromTheme(
            ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: 14),
                bodyText2: TextStyle(fontSize: 14),
              ),
            ),
          ),
          selectable: true,
          data: state.content.value ?? "",
        ),
      ),
    );
  }
}
