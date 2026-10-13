import 'package:apk_analyzer/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apk_analyzer/utils/helpers/app_globals.dart';
import 'package:apk_analyzer/utils/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        builder: (context, child) {
          return child!;
        },
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        title: 'APK Analyzer',
        home: const HomeScreen(),
      ),
    );
  }
}
