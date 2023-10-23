import 'package:flutter/widgets.dart';
import 'package:keyboard_attachable/src/animation/keyboard_animation_controller.dart';
import 'package:flutter/physics.dart';


class AndroidKeyboardAnimationController1 implements KeyboardAnimationController {
  AndroidKeyboardAnimationController1({required TickerProvider vsync}):
      //mass 1, stiffness 100, damping 10 velocity 15 duration 300
  //mass 0, stiffness 0, damping 5 velocity 30 duration 300
        _spring = const SpringDescription(mass: 10, stiffness: 0, damping: 10),
        _springVelocity = 30,
        _controller = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 400));

  final SpringDescription _spring;
  final double _springVelocity;
  final AnimationController _controller;

  @override
  Animation<double> get animation => _controller;

  @override
  TickerFuture forward() {
    //final forwardSimulation = ClampingScrollSimulation(position: 100, velocity: _springVelocity);
    final forwardSimulation = SpringSimulation(_spring, 0, 1,  _springVelocity);
    return _controller.animateWith(forwardSimulation);
  }


  @override
  TickerFuture reverse() {
    final reverseSimulation = ClampingScrollSimulation(position: 0, velocity: _springVelocity);
   // final reverseSimulation = SpringSimulation(_spring, 1, 0, _springVelocity);
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

