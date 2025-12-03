import 'package:flutter/material.dart';
import '../constants/colors_manager.dart';
import '../constants/styles_manager.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final TextStyle? textStyle;
  final String? semanticLabel;
  final EdgeInsetsGeometry padding;
  final bool enabled;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.textStyle,
    this.semanticLabel,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onPressed != null;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: semanticLabel ?? text,
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: TextButton.styleFrom(
          padding: padding,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: textColor ?? AppColors.textLink,
        ),
        child: Text(
          text,
          style: (textStyle ?? AppStyles.buttonSecondary).copyWith(
            color: isEnabled
                ? (textColor ?? AppColors.textLink)
                : AppColors.textHint,
          ),
        ),
      ),
    );
  }
}
