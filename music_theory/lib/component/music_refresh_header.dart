import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lottie/lottie.dart';

class MusicRefreshHeader extends Header {
  final Key key;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  MusicRefreshHeader({
    this.key,
    bool enableHapticFeedback = false,
  }) : super(
          float: false,
          extent: 50.0,
          triggerDistance: 50.0,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return MaterialHeaderWidget(
      key: key,
      linkNotifier: linkNotifier,
    );
  }
}

class MaterialHeaderWidget extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const MaterialHeaderWidget({
    Key key,
    this.linkNotifier,
  }) : super(key: key);

  @override
  MaterialHeaderWidgetState createState() {
    return MaterialHeaderWidgetState();
  }
}

class MaterialHeaderWidgetState extends State<MaterialHeaderWidget>
    with TickerProviderStateMixin<MaterialHeaderWidget> {
  AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _lottieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.linkNotifier.refreshState == RefreshMode.armed) {
      _lottieController.repeat();
    } else if (widget.linkNotifier.refreshState == RefreshMode.done) {
      _lottieController.reset();
    }

    return Container(
      color: Colors.white,
      child: SizedBox(
        child: Center(
          child: Lottie.asset(
            'assets/music_note.json',
            width: 40,
            height: 40,
            controller: _lottieController,
            onLoaded: (composition) {
              _lottieController
                ..duration = composition.duration
                ..repeat();
            },
          ),
        ),
      ),
    );
  }
}
