import 'package:flutter/material.dart';

class ZoomContainer extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkMode;
  ZoomContainer({ Key? key, required this.controller, required this.isDarkMode}) :
  zoomAnimation = Tween(begin: 1000.0, end: 0.0).animate(
    CurvedAnimation(parent: controller, curve: Curves.ease)
  ),
  super(key: key);

  final Animation<double> zoomAnimation;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "zoom",
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: zoomAnimation.value,
            height: zoomAnimation.value,
            decoration: BoxDecoration(
              shape: zoomAnimation.value <= MediaQuery.of(context).size.width ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: zoomAnimation.value < MediaQuery.of(context).size.width ? null : BorderRadius.circular(20),
              color: isDarkMode ? Colors.black87 : Colors.white60
            ),
          );
        },
      ),
    );
  }
}