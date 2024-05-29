import 'package:flutter/material.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/presentation/pages/auth/onboarding.dart';
import 'package:healtech/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).theme,
      routes: routes,
      home: const OnBoarding(),
    );
  }
}
