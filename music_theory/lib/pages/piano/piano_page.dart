import 'package:flutter/material.dart';

import 'component/piano_landscape.dart';
import 'component/piano_portrait.dart';

/// 钢琴窗页面
class PianoPage extends StatefulWidget {
  @override
  _PianoPageState createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return PianoLandscape();
        } else {
          return PianoPortrait();
        }
      },
    );
  }
}
