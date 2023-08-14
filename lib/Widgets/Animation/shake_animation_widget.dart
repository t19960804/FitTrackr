import 'package:flutter/material.dart';
import 'package:fit_trackr/Helpers/shake_animation_helper.dart';

class ShakeAnimationWidget extends StatefulWidget {
  final bool isShaking;
  final Widget child;
  const ShakeAnimationWidget(
      {super.key, required this.isShaking, required this.child});

  @override
  State<ShakeAnimationWidget> createState() => _ShakeAnimationWidgetState();
}

class _ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with TickerProviderStateMixin {
  late ShakeAnimationHelper helper;

  @override
  void initState() {
    super.initState();
    helper = ShakeAnimationHelper(provider: this);
    _checkIfDoShakeAnimation();
  }

  @override
  void didUpdateWidget(ShakeAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkIfDoShakeAnimation();
  }

  void _checkIfDoShakeAnimation() {
    if (widget.isShaking == true) {
      helper.start();
    } else {
      helper.stop();
    }
  }

  @override
  void dispose() {
    helper.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: helper.animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: helper.getShakingAngle(widget.isShaking),
          child: widget.child,
        );
      },
    );
  }
}
