import 'package:flutter/material.dart';

class HeroText extends StatelessWidget {
  const HeroText(
    this.text, {
    required this.tag,
    this.textAlign,
    this.style,
  });

  final String text;
  final String tag;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: Text(
          text,
          textAlign: textAlign,
          style: style,
        ),
      ),
    );
  }
}
