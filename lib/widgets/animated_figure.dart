import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFigure extends StatefulWidget {
  const AnimatedFigure({Key? key}) : super(key: key);

  @override
  _AnimatedFigureState createState() => _AnimatedFigureState();
}

class _AnimatedFigureState extends State<AnimatedFigure>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignment;
  late Animation<double> _rotationAngle;

  TweenSequenceItem<Alignment> _createAlignmentTweenSequenceItem({
    required Alignment initialValue,
    required Alignment finalValue,
    required Interval interval,
  }) {
    return TweenSequenceItem<Alignment>(
      tween: Tween<Alignment>(
        begin: initialValue,
        end: finalValue,
      ).chain(
        CurveTween(
          curve: interval,
        ),
      ),
      weight: 1.0,
    );
  }

  TweenSequenceItem<double> _createRotationAngleTweenSequenceItem({
    required double initialValue,
    required double finalValue,
    required Interval interval,
  }) {
    return TweenSequenceItem<double>(
      tween: Tween<double>(
        begin: initialValue,
        end: finalValue,
      ).chain(
        CurveTween(
          curve: interval,
        ),
      ),
      weight: 1.0,
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _alignment = TweenSequence(
      <TweenSequenceItem<Alignment>>[
        _createAlignmentTweenSequenceItem(
          initialValue: Alignment.bottomLeft,
          finalValue: Alignment.topLeft,
          interval: const Interval(1 / 16, 0.25),
        ),
        _createAlignmentTweenSequenceItem(
          initialValue: Alignment.topLeft,
          finalValue: Alignment.topRight,
          interval: const Interval(5 / 16, 0.5),
        ),
        _createAlignmentTweenSequenceItem(
          initialValue: Alignment.topRight,
          finalValue: Alignment.bottomRight,
          interval: const Interval(9 / 16, 0.75),
        ),
        _createAlignmentTweenSequenceItem(
          initialValue: Alignment.bottomRight,
          finalValue: Alignment.bottomLeft,
          interval: const Interval(13 / 16, 1.0),
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1.0),
      ),
    );

    _rotationAngle = TweenSequence(
      <TweenSequenceItem<double>>[
        _createRotationAngleTweenSequenceItem(
          initialValue: 0,
          finalValue: 90.0,
          interval: const Interval(0, 1 / 16),
        ),
        _createRotationAngleTweenSequenceItem(
          initialValue: 90.0,
          finalValue: 180.0,
          interval: const Interval(0.25, 5 / 16),
        ),
        _createRotationAngleTweenSequenceItem(
          initialValue: 180.0,
          finalValue: 270.0,
          interval: const Interval(0.5, 9 / 16),
        ),
        _createRotationAngleTweenSequenceItem(
          initialValue: 270.0,
          finalValue: 360.0,
          interval: const Interval(0.75, 13 / 16),
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1.0),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 240.0,
          width: 240.0,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: _alignment.value,
                child: Transform.rotate(
                  angle: _rotationAngle.value * pi / 180.0,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    color: Colors.red[400],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
