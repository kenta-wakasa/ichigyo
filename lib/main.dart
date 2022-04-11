import 'package:flutter/material.dart';

import 'configs/app_theme.dart';
import 'database/hive_manager.dart';
import 'pages/home_page.dart';

void main() async {
  await HiveManager.instance.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}
