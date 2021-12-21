import 'package:flutter/material.dart';

import 'piano_octave.dart';

class PianoView extends StatefulWidget {
  const PianoView({
    this.keyWidth,
  });

  final double keyWidth;

  @override
  _PianoViewState createState() => _PianoViewState();
}

class _PianoViewState extends State<PianoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return PianoOctave(
          octave: index * 12,
          keyWidth: widget.keyWidth,
        );
      },
    );
  }
}
