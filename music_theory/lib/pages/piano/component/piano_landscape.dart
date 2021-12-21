import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/pages/piano/component/piano_view.dart';
import 'package:music/utils/color_utils.dart';

class PianoLandscape extends StatefulWidget {
  @override
  _PianoLandscapeState createState() => _PianoLandscapeState();
}

class _PianoLandscapeState extends State<PianoLandscape> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        elevation: 1,
        actions: [
          IconButton(
              icon: Icon(
                Icons.fullscreen_exit,
                color: ColorUtils.black,
              ),
              onPressed: () {
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: PianoView(
          keyWidth: 50,
        ),
      ),
    );
  }
}
