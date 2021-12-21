import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/component/commom_picker.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/utils/color_utils.dart';

/// 节拍器页面
class MetronomePage extends StatefulWidget {
  @override
  _MetronomePageState createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage>
    with AutomaticKeepAliveClientMixin {
  Timer _timer;

  bool _isPlaying = false;
  final player = AudioPlayer();
  final player2 = AudioPlayer();

  /// 默认 60bpm
  int _bpm = 100;

  /// 间隔时间
  int _duration;

  /// 当前次数
  int _beat = 0;

  /// 以4分音符为一拍
  int _note = 4;

  /// 每小节有4拍
  int _count = 4;

  List<String> _list = ["1/4", "2/4", "3/4", "4/4", "3/8", "6/8"];

  List<BeatItemWidget> _widgets = List();

  /// 加key防止外层widget build时重用之前BeatItemWidget
  /// 加上key之后会重新走initState，把controller初始化出来
  List<GlobalKey<_BeatItemWidgetState>> _keys = List();

  _play1() async {
    await player.setAsset('assets/sound1.wav', preload: true);
    await player.play();
  }

  _play2() async {
    await player2.setAsset('assets/sound2.wav', preload: true);
    await player2.play();
  }

  _stop() async {
    await player.stop();
    await player2.stop();
  }

  _startAnimationAndBeat() {
    _duration = 60 * 1000 ~/ _bpm * 4 ~/ _note;
    if (_timer != null) {
      _timer.cancel();
    }
    _stop();
    _timer = Timer.periodic(Duration(milliseconds: _duration), (timer) {
      int current = _beat % _widgets.length;
      _keys[current].currentState.start();
      if (current == 0) {
        _play2();
      } else {
        _play1();
      }
      _beat++;
    });
  }

  _stopAnimationAndBeat() {
    _beat = 0;
    if (_timer != null) {
      _timer.cancel();
    }
    _stop();
  }

  @override
  void initState() {
    super.initState();
    _duration = 60 * 1000 ~/ _bpm * 4 ~/ _note;
    _initWidgets();
  }

  _initWidgets() {
    _widgets.clear();
    _keys.clear();
    for (int i = 0; i < _count; i++) {
      GlobalKey<_BeatItemWidgetState> key = GlobalKey<_BeatItemWidgetState>();
      BeatItemWidget widget = BeatItemWidget(key: key);
      _keys.add(key);
      _widgets.add(widget);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CommonAppBar(
        leading: Container(),
        title: Text(
          "节拍器",
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 60,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorUtils.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CommonPicker(
                            data: _list,
                            onSelected: (index, index2, index3) {
                              String s = _list[index];
                              setState(() {
                                _count = int.parse(s.substring(0, 1));
                                _note = int.parse(s.substring(2, 3));
                                _initWidgets();
                              });
                            },
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "拍号",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$_count/$_note",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "bpm $_bpm",
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorUtils.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: FlatButton(
                      color: ColorUtils.dark_blue,
                      shape: CircleBorder(),
                      onPressed: () {
                        if (_bpm >= 300) {
                          return;
                        }
                        setState(() {
                          _bpm++;
                          if (_isPlaying) {
                            _startAnimationAndBeat();
                          }
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.add,
                        size: 26,
                        color: ColorUtils.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    width: 50,
                    height: 50,
                    child: FlatButton(
                      color: ColorUtils.dark_blue,
                      shape: CircleBorder(),
                      onPressed: () {
                        if (_isPlaying) {
                          _stopAnimationAndBeat();
                        } else {
                          _startAnimationAndBeat();
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 26,
                        color: ColorUtils.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    width: 40,
                    height: 40,
                    child: FlatButton(
                      color: ColorUtils.dark_blue,
                      shape: CircleBorder(),
                      onPressed: () {
                        if (_bpm <= 1) {
                          return;
                        }
                        setState(() {
                          _bpm--;
                          if (_isPlaying) {
                            _startAnimationAndBeat();
                          }
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.remove,
                        size: 26,
                        color: ColorUtils.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BeatItemWidget extends StatefulWidget {
  BeatItemWidget({Key key}) : super(key: key);

  @override
  _BeatItemWidgetState createState() => _BeatItemWidgetState();
}

class _BeatItemWidgetState extends State<BeatItemWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 10, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
  }

  start() {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 80,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
        height: animation.value,
        width: 5,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
