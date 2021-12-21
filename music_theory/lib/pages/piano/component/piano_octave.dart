import 'package:flutter/material.dart';

import 'piano_key.dart';

class PianoOctave extends StatelessWidget {
  const PianoOctave({
    this.keyWidth,
    this.octave,
  });

  final double keyWidth;
  final int octave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          _buildPianoKey(24, false),
          _buildPianoKey(26, false),
          _buildPianoKey(28, false),
          _buildPianoKey(29, false),
          _buildPianoKey(31, false),
          _buildPianoKey(33, false),
          _buildPianoKey(35, false),
        ]),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 115,
          top: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: keyWidth * .5),
              _buildPianoKey(25, true),
              _buildPianoKey(27, true),
              Container(width: keyWidth),
              _buildPianoKey(30, true),
              _buildPianoKey(32, true),
              _buildPianoKey(34, true),
              Container(width: keyWidth * .5),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildPianoKey(int midi, bool accidental) {
    return PianoKey(
      midi: midi + octave,
      accidental: accidental,
      keyWidth: keyWidth,
    );
  }
}
