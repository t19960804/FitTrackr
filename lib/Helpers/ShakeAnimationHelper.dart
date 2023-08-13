import 'package:flutter/material.dart';

class ShakeAnimationHelper {
  late AnimationController controller;
  late Animation<double> animation;
  final TickerProvider provider;

  ShakeAnimationHelper({required this.provider}) {
    _setupShakeAnimation();
  }

  void _setupShakeAnimation() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: provider,
    )..repeat(reverse: true);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.stop();
  }

  void start() {
    controller.repeat(reverse: true);
  }

  void stop() {
    controller.stop();
  }
}
