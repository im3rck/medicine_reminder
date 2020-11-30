import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Logo extends StatefulWidget {
  final Color color;
  final double size;

  const Logo({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  double opacityLevel = 1.0;
  @override
  void initState() {
    super.initState();
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/Rive/pill4.riv').then(
          (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('SpinLoad'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xffbb86fe),
      height: (MediaQuery.of(context).size.height)*.06,
      width: (MediaQuery.of(context).size.width)*.08,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard),
    );
    //   Transform.rotate(
    //   angle: -pi / 4,
    //   child: Icon(
    //     Icons.format_bold,
    //     color: widget.color,
    //     size: widget.size,
    //   ),
    // );
  }
}