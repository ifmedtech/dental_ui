import 'package:dental_ui/core/theme/app_theme.dart';
import 'package:dental_ui/core/router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OraVue',
      theme: MaterialTheme.theme(MaterialTheme.lightScheme().toColorScheme()),
      darkTheme:
          MaterialTheme.theme(MaterialTheme.darkScheme().toColorScheme()),
      routerConfig: Routing.goRouter,
    );
  }
}
