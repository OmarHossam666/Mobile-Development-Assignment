import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/strings_manager.dart';
import '../../../core/constants/styles_manager.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  LoginProvider? _loginProvider;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginProvider ??= context.read<LoginProvider>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _loginProvider?.clearSensitiveData();

    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    final provider = context.read<LoginProvider>();
    final success = await provider.login();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: AppColors.success,
        ),
      );
    } else if (provider.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage!),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed(AppStrings.registerRoute);
  }

  void _navigateToForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot password feature coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: AppStrings.loginTitle,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.screenPadding,
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spacingMd),
                  const SectionTitle(text: AppStrings.continueWithEmail),
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
                    label: AppStrings.password,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    showPasswordToggle: true,
                    isPasswordVisible: provider.isPasswordVisible,
                    onTogglePasswordVisibility:
                        provider.togglePasswordVisibility,
                    textInputAction: TextInputAction.done,
                    errorText: provider.passwordError,
                    onChanged: provider.setPassword,
                    onEditingComplete: _handleLogin,
                    semanticLabel: AppStrings.passwordInputLabel,
                  ),
                  const SizedBox(height: AppDimensions.spacingXl),
                  PrimaryButton(
                    text: AppStrings.login,
                    onPressed: _handleLogin,
                    isLoading: provider.isLoading,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextButton(
                        text: AppStrings.forgotPassword,
                        onPressed: _navigateToForgotPassword,
                      ),
                      CustomTextButton(
                        text: AppStrings.createAccount,
                        onPressed: _navigateToRegister,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
