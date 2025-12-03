import 'package:flutter/material.dart';
import 'package:mobile_development_assignment/core/constants/themes_manager.dart';
import 'package:mobile_development_assignment/features/auth/providers/register_provider.dart';
import 'package:provider/provider.dart';
import 'features/auth/providers/login_provider.dart';
import 'core/constants/strings_manager.dart';
import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: const MobileDevelopmentAssignment(),
    ),
  );
}

class MobileDevelopmentAssignment extends StatelessWidget {
  const MobileDevelopmentAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: AppStrings.loginRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
