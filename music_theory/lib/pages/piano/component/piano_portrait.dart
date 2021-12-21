import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/pages/piano/component/piano_view.dart';
import 'package:music/utils/color_utils.dart';

class PianoPortrait extends StatefulWidget {
  @override
  _PianoPortraitState createState() => _PianoPortraitState();
}

class _PianoPortraitState extends State<PianoPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        elevation: 1,
        actions: [
          IconButton(
              icon: Icon(
                Icons.fullscreen_sharp,
                color: ColorUtils.black,
              ),
              onPressed: () {
                SystemChrome.setEnabledSystemUIOverlays([]);
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                ]);
              })
        ],
        title: Text(
          "钢琴窗",
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 300,
              child: PianoView(
                keyWidth: 50,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "以上是钢琴的7个八度，音名只有七个，而音列中的音却大大超过这个数量，如何把音名相同而音高不同的音区别开来呢？方法就是分组。如下："
                "\n"
                "\n大字二组：省略"
                "\n大字一组：C1-B1"
                "\n大字组：C2-B2"
                "\n小字组：C3-B3"
                "\n小字一组：C4-B4"
                "\n小字二组：C5-B6"
                "\n小字三组：C6-B6"
                "\n小字四组：C7-B7"
                "\n小字五组：省略"
                "\n"
                "\n其中小字一组，也就是C4被称为中央C",
                style: TextStyle(letterSpacing: 2, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
