import 'package:flutter/material.dart';
import 'package:movie_demo/widgets/gradient_text.dart';

class KErrorWidget extends StatelessWidget {
  final String message;

  final Function onPressed;

  const KErrorWidget({
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomGradientText(
            size: 16,
            content: message,
            primaryColor: Colors.lightBlueAccent,
            secondaryColor: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}
