import 'package:flutter/material.dart';
import '../constants/colors_manager.dart';
import '../constants/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final TextStyle? titleStyle;
  final IconData backIcon;
  final Color? backIconColor;
  final Color? backgroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true,
    this.titleStyle,
    this.backIcon = Icons.arrow_back,
    this.backIconColor,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? Semantics(
              button: true,
              label: 'Go back',
              child: IconButton(
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                icon: Icon(
                  backIcon,
                  color: backIconColor ?? AppColors.textPrimary,
                  size: AppDimensions.iconMd,
                ),
                tooltip: 'Back',
              ),
            )
          : null,
      title: Text(title, style: titleStyle ?? AppStyles.headingMedium),
    );
  }
}
