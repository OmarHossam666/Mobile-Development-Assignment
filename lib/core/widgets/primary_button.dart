import 'package:flutter/material.dart';
import '../constants/colors_manager.dart';
import '../constants/styles_manager.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final String? semanticLabel;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height = AppDimensions.buttonHeight,
    this.backgroundColor,
    this.textColor,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onPressed != null && !isLoading;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: semanticLabel ?? text,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? (backgroundColor ?? AppColors.buttonPrimary)
                : AppColors.buttonDisabled,
            foregroundColor: isEnabled
                ? (textColor ?? AppColors.buttonTextPrimary)
                : AppColors.buttonTextDisabled,
            disabledBackgroundColor: AppColors.buttonDisabled,
            disabledForegroundColor: AppColors.buttonTextDisabled,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: isLoading
              ? _buildLoadingIndicator()
              : Text(
                  text,
                  style: AppStyles.buttonPrimary.copyWith(
                    color: isEnabled
                        ? (textColor ?? AppColors.buttonTextPrimary)
                        : AppColors.buttonTextDisabled,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
      ),
    );
  }
}
