import 'package:flutter/material.dart';
import '../constants/colors_manager.dart';
import '../constants/styles_manager.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;
  final TextStyle? labelStyle;
  final bool enabled;
  final String? semanticLabel;
  final Color? activeColor;
  final Color? checkColor;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
    this.labelStyle,
    this.enabled = true,
    this.semanticLabel,
    this.activeColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      checked: value,
      enabled: enabled,
      child: InkWell(
        onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: value,
                  onChanged: enabled ? onChanged : null,
                  activeColor: activeColor ?? AppColors.checkboxActive,
                  checkColor: checkColor ?? AppColors.white,
                  side: BorderSide(
                    color: value
                        ? (activeColor ?? AppColors.checkboxActive)
                        : AppColors.checkboxBorder,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    label,
                    style:
                        labelStyle ??
                        AppStyles.checkboxLabel.copyWith(
                          color: enabled
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
