import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkMode;
  AnimatedLogo({ Key? key, required this.controller, required this.isDarkMode}) :
    size = Tween(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut))
    ),
    rotation = Tween(begin: 0.0, end: -0.1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.4, 0.8, curve: Curves.bounceOut))
    ),
    zoom = Tween(begin: 200.0, end: 1000.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.8, 1, curve: Curves.easeOutQuad))
    ),
    super(key: key);

  final Animation<double> rotation;
  final Animation<double> size;
  final Animation<double> zoom;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return rotation.value != -0.1 
          ? RotationTransition(
            turns: rotation,
            child: Container(
                width: MediaQuery.of(context).size.width * size.value,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: isDarkMode ? const AssetImage("assets/images/logo_dark.png") : const AssetImage("assets/images/logo_light.png"),
                    fit: BoxFit.contain,
                  )
                ),
              ),
          )
          : Hero(
            tag: "zoom",
            child: Container(
                width: zoom.value,
                height: zoom.value,
                decoration: BoxDecoration(
                  shape: zoom.value <= MediaQuery.of(context).size.width ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: zoom.value < MediaQuery.of(context).size.width ? null : BorderRadius.circular(20),
                  color: isDarkMode ? Colors.black87 : Colors.white60
                ),
              ),
          );
      }
    );
  }
}