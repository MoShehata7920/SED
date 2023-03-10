import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

class AnimationInfo {
  AnimationInfo({
    required this.trigger,
    required this.effects,
    this.loop = false,
    this.reverse = false,
    this.applyInitialState = true,
  });

  final AnimationTrigger trigger;
  final List<Effect<dynamic>> effects;
  final bool applyInitialState;
  final bool loop;
  final bool reverse;
  late Adapter adapter;
  late AnimationController controller;
}

extension AnimatedWidgetExtension on Widget {
  Widget animateOnPageLoad({int msDelay = 0, double dx = 0,double dy = 0, showDelay = 0}) {
    AnimationInfo animationInfo = getDefaultAnimation(msDelay, dx, dy, showDelay);
    return Animate(
        controller:
        animationInfo.applyInitialState ? null : animationInfo.controller,
        adapter: animationInfo.applyInitialState ? null : animationInfo.adapter,
        effects: animationInfo.effects,
        child: this,
        onPlay: (controller) => animationInfo.loop
            ? controller.repeat(reverse: animationInfo.reverse)
            : null,
        onComplete: (controller) => !animationInfo.loop && animationInfo.reverse
            ? controller.reverse()
            : null);
  }
}

AnimationInfo getDefaultAnimation(int msDelay,double dx, double dy, int showDelay) {
  return AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      VisibilityEffect(duration: msDelay.ms),
      FadeEffect(
        curve: Curves.easeInOut,
        delay: msDelay.ms,
        duration: showDelay.ms,
        begin: 0.0,
        end: 1.0,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: msDelay.ms,
        duration: showDelay.ms,
        begin: Offset(dx, dy),
        end: const Offset(0.0, 0.0),
      ),
    ],
  );
}
