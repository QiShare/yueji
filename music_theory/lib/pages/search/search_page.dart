import 'package:flutter/material.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/utils/color_utils.dart';

/// 搜索页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Text(
          "搜索",
          style: TextStyle(
            color: ColorUtils.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
