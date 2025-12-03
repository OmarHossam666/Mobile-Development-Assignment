import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/strings_manager.dart';
import '../../../core/constants/styles_manager.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/custom_check_box.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  RegisterProvider? _registerProvider;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registerProvider ??= context.read<RegisterProvider>();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _registerProvider?.clearSensitiveData();

    super.dispose();
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    final provider = context.read<RegisterProvider>();
    final success = await provider.register();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.of(context).pop();
    } else if (provider.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage!),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _openPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy policy coming soon!')),
    );
  }

  void _openTermsOfUse() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Terms of use coming soon!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: AppStrings.welcomeToTalabat,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.screenPadding,
          child: Consumer<RegisterProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spacingMd),
                  const SectionTitle(text: AppStrings.continueWithEmail),
                  CustomTextField(
                    label: AppStrings.firstName,
                    controller: _firstNameController,
                    focusNode: _firstNameFocusNode,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    errorText: provider.firstNameError,
                    onChanged: provider.setFirstName,
                    onEditingComplete: () {
                      _lastNameFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  CustomTextField(
                    label: AppStrings.lastName,
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    errorText: provider.lastNameError,
                    onChanged: provider.setLastName,
                    onEditingComplete: () {
                      _emailFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  CustomTextField(
                    label: AppStrings.email,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    errorText: provider.emailError,
                    onChanged: provider.setEmail,
                    onEditingComplete: () {
                      _passwordFocusNode.requestFocus();
                    },
                    semanticLabel: AppStrings.emailInputLabel,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  CustomTextField(
                    label: AppStrings.choosePassword,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    showPasswordToggle: true,
                    isPasswordVisible: provider.isPasswordVisible,
                    onTogglePasswordVisibility:
                        provider.togglePasswordVisibility,
                    textInputAction: TextInputAction.done,
                    errorText: provider.passwordError,
                    helperText: AppStrings.passwordRequirement,
                    onChanged: provider.setPassword,
                    onEditingComplete: _handleRegister,
                    semanticLabel: AppStrings.passwordInputLabel,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  CustomCheckBox(
                    value: provider.wantsOffers,
                    label: AppStrings.receiveOffersText,
                    onChanged: (value) =>
                        provider.setWantsOffers(value ?? false),
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  PrimaryButton(
                    text: AppStrings.createAccountButton,
                    onPressed: _handleRegister,
                    isLoading: provider.isLoading,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  _buildTermsText(),
                  const SizedBox(height: AppDimensions.spacingXl),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return RichText(
      text: TextSpan(
        style: AppStyles.bodySmall,
        children: [
          const TextSpan(text: '${AppStrings.termsPrefix} '),
          TextSpan(
            text: AppStrings.privacyPolicy,
            style: AppStyles.link.copyWith(fontSize: 12),
            recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy,
          ),
          const TextSpan(text: '\n${AppStrings.termsMiddle} '),
          TextSpan(
            text: AppStrings.termsOfUse,
            style: AppStyles.link.copyWith(fontSize: 12),
            recognizer: TapGestureRecognizer()..onTap = _openTermsOfUse,
          ),
        ],
      ),
    );
  }
}
