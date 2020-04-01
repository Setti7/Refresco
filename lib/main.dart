import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:refresco/core/models/user.dart';
import 'package:refresco/core/services/auth/auth_service.dart';
import 'package:refresco/locator.dart';
import 'package:refresco/ui/views/buy_view.dart';

import 'ui/theme.dart';

void main() {
  Logger.level = Level.debug;
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (context) => locator<AuthService>().user,
      initialData: User(),
      child: MaterialApp(
        title: 'Refresco',
        theme: ThemeData(
          primarySwatch: AppColors.primary,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          accentColor: AppColors.accent,
          buttonTheme: AppThemes.buttonTheme,
          accentTextTheme: AppThemes.accentTextTheme,
          inputDecorationTheme: AppThemes.inputDecorationTheme,
          cardTheme: AppThemes.cardTheme,
        ),
        home: BuyView(),
      ),
    );
  }
}
