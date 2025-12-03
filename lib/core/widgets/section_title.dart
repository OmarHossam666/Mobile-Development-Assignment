import 'package:flutter/material.dart';
import '../constants/styles_manager.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;

  const SectionTitle({
    super.key,
    required this.text,
    this.style,
    this.padding = const EdgeInsets.only(bottom: 24),
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: style ?? AppStyles.sectionTitle,
        textAlign: textAlign,
      ),
    );
  }
}
