import 'package:flutter/material.dart';
import 'package:tonic/tonic.dart';

class PianoKey extends StatelessWidget {
  const PianoKey({
    @required this.keyWidth,
    this.midi,
    this.accidental,
  });

  final bool accidental;
  final double keyWidth;
  final int midi;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      highlightColor: Colors.black,
      onTap: () {},
      onTapDown: (_) {},
      onTapCancel: () {},
      child: Builder(
        builder: (_) {
          final pitchName = Pitch.fromMidiNumber(midi).toString();
          final pianoKey = Stack(
            children: [
              Positioned.fill(
                child: Semantics(
                    button: true,
                    hint: pitchName,
                    child: Material(
                      borderRadius: _borderRadius,
                      color: accidental ? Colors.black : Colors.white,
                    )),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 20.0,
                child: Text(
                  pitchName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: !accidental ? Colors.black : Colors.white),
                ),
              ),
            ],
          );
          if (accidental) {
            return Container(
              width: keyWidth,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              padding: EdgeInsets.symmetric(horizontal: keyWidth * .1),
              child: Material(
                  elevation: 5.0,
                  borderRadius: _borderRadius,
                  shadowColor: Colors.blue,
                  child: pianoKey),
            );
          }
          return Container(
            width: keyWidth,
            child: pianoKey,
            margin: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          );
        },
      ),
    );
  }
}

const BorderRadiusGeometry _borderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(10.0),
  bottomRight: Radius.circular(10.0),
);
