import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final controller = ThemeController.instance;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: controller.mode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Regl Takip',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          home: const AppShell(),
        );
      },
    );
  }
}
