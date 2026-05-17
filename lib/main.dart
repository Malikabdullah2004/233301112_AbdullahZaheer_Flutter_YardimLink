import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/app_theme.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const YardimLinkApp());
}

class YardimLinkApp extends StatefulWidget {
  const YardimLinkApp({super.key});

  static YardimLinkAppState of(BuildContext context) {
    return context.findAncestorStateOfType<YardimLinkAppState>()!;
  }

  @override
  State<YardimLinkApp> createState() => YardimLinkAppState();
}

class YardimLinkAppState extends State<YardimLinkApp> {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode {
    return themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'YardimLink',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeMode,

      home: const AuthWrapper(),
    );
  }
}
