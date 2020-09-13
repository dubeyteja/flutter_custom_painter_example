import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'animated_circle.dart';

class AnimatedView extends StatefulWidget {
  @override
  _AnimatedViewState createState() => _AnimatedViewState();
}

class _AnimatedViewState extends State<AnimatedView>
    with SingleTickerProviderStateMixin {
  Animation animation;
  Animation opacity;
  AnimationController animationController;
  int sAngle;
  int mAngle;
  int lAngle;
  Random random = new Random();
  Timer timer;

  @override
  void initState() {
    super.initState();
    sAngle = random.nextInt(360);
    mAngle = random.nextInt(360);
    lAngle = random.nextInt(360);
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      sAngle = random.nextInt(360);
      mAngle = random.nextInt(360);
      lAngle = random.nextInt(360);
    });
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    opacity = Tween<double>(begin: 0.8, end: 0.0).animate(
        new CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animation = Tween<double>(begin: 0, end: 140).animate(new CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          animationController.repeat();
        }
      });
    animationController.forward();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: AnimatedCircle(
            value: animation.value,
            sAngle: sAngle,
            mAngle: mAngle,
            lAngle: lAngle,
            opacity: opacity.value,
            showOnxSmallCircle: true,
            showOnLargeCircle: true,
            showOnMediumCircle: true),
      ),
    );
  }
}
