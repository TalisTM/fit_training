import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkMode;
  AnimatedLogo({ Key? key, required this.controller, required this.isDarkMode}) :
    size = Tween(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut))
    ),
    rotation = Tween(begin: 0.0, end: -0.1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.4, 0.7, curve: Curves.bounceOut))
    ),
    super(key: key);

  final Animation<double> rotation;
  final Animation<double> size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return RotationTransition(
          turns: rotation,
          child: Container(
              width: MediaQuery.of(context).size.width * size.value,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: isDarkMode ? const AssetImage("assets/images/logo_dark.png") : const AssetImage("assets/images/logo_light.png"),
                  fit: BoxFit.contain,
                )
              ),
            )
        );
      }
    );
  }
}