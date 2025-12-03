import 'package:flutter/material.dart';
import '../constants/colors_manager.dart';
import '../constants/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? value;
  final bool obscureText;
  final bool showPasswordToggle;
  final VoidCallback? onTogglePasswordVisibility;
  final bool isPasswordVisible;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? semanticLabel;
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.onChanged,
    this.value,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.onTogglePasswordVisibility,
    this.isPasswordVisible = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.focusNode,
    this.onEditingComplete,
    this.semanticLabel,
    this.controller,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final shouldObscure = obscureText && !isPasswordVisible;

    return Semantics(
      label: semanticLabel ?? label,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            obscureText: shouldObscure,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            style: AppStyles.inputText,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              labelStyle: AppStyles.inputHint,
              hintStyle: AppStyles.inputHint,
              errorText: errorText,
              errorStyle: AppStyles.inputError,
              helperText: helperText,
              helperStyle: AppStyles.inputHelper,
              helperMaxLines: 2,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.borderFocused,
                  width: 2,
                ),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderError, width: 1),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderError, width: 2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              suffixIcon: showPasswordToggle ? _buildPasswordToggle() : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordToggle() {
    return Semantics(
      button: true,
      label: isPasswordVisible ? 'Hide password' : 'Show password',
      child: GestureDetector(
        onTap: onTogglePasswordVisibility,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            isPasswordVisible ? 'Hide' : 'Show',
            style: AppStyles.buttonSecondary,
          ),
        ),
      ),
    );
  }
}
