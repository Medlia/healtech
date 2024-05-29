import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:healtech/app.dart';
import 'package:healtech/presentation/providers/theme_provider.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/src/api_key.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.firebase().initialize();
  Gemini.init(apiKey: apiKey);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
