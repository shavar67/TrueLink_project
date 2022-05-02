import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class CustomGradientText extends StatelessWidget {
  final String content;
  final Color primaryColor;
  final Color secondaryColor;
  final double size;

  const CustomGradientText(
      {required this.content,
      required this.primaryColor,
      required this.secondaryColor,
      required this.size})
      : super();
  @override
  Widget build(BuildContext context) {
    return GradientText(
      content,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w500),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, secondaryColor]),
    );
  }
}
