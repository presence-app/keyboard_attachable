import 'package:flutter/widgets.dart';
import 'package:keyboard_attachable/src/animation/keyboard_animation_controller.dart';
import 'package:flutter/physics.dart';


class AndroidKeyboardAnimationController implements KeyboardAnimationController {
  AndroidKeyboardAnimationController({required TickerProvider vsync}):
        _spring = const SpringDescription(mass: 1, stiffness: 100, damping: 10),
        _springVelocity = 15,
        _controller = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 350));

  final SpringDescription _spring;
  final double _springVelocity;
  final AnimationController _controller;

  @override
  Animation<double> get animation => _controller;

  @override
  TickerFuture forward() {
    final forwardSimulation = ClampingScrollSimulation(position: 100, velocity: _springVelocity);
    return _controller.animateWith(forwardSimulation);
  }


  @override
  TickerFuture reverse() {
    final reverseSimulation = ClampingScrollSimulation(position: 0, velocity: _springVelocity);
    return _controller.animateWith(reverseSimulation);
  }


/*
  TickerFuture forward() {
    final forwardSimulation = SpringSimulation(_spring, 0, 100, _springVelocity);
    return _controller.animateWith(forwardSimulation);
  }
  */


  /*
  @override
  TickerFuture reverse() {
    final reverseSimulation = SpringSimulation(_spring, 100, 0, -15);
    return _controller.animateWith(reverseSimulation);
  }
  */


  @override
  void dispose() => _controller.dispose();
}





/* OLD VERSION
class AndroidKeyboardAnimationController
    implements KeyboardAnimationController {
  AndroidKeyboardAnimationController({required TickerProvider vsync})
      : _controller = AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 140),
          reverseDuration: const Duration(milliseconds: 100),
        );

  final AnimationController _controller;

  @override
  Animation<double> get animation => CurvedAnimation(
        parent: _controller,
        curve: const Cubic(0, 0, 0.1, 0.9),
        reverseCurve: const Cubic(0, 0, 1, 0.2),
      );

  @override
  void dispose() => _controller.dispose();

  @override
  TickerFuture forward() => _controller.forward();

  @override
  TickerFuture reverse() => _controller.reverse();
}
*/