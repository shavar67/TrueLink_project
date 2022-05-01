import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String content;
  final double size;
  final Color color;
  const CustomText(
      {Key? key,
      required this.content,
      required this.size,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(content,
        minFontSize: 12,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
            fontSize: size, fontWeight: FontWeight.w700, color: color));
  }
}
