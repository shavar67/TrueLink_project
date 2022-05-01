import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String content;
  final double size;
  final Color color;

  const CustomText(
      {required this.content, required this.size, required this.color})
      : super();
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      content,
      style: GoogleFonts.lato(
          fontSize: size, fontWeight: FontWeight.bold, color: color),
    );
  }
}
