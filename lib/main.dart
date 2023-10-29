import 'package:doggy/splash.dart';
import 'package:doggy/utils/providers.dart';
import 'package:doggy/utils/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: 'Doggy',
            debugShowCheckedModeBanner: false,
            theme: themeData(
              ThemeConfig.lightTheme,
            ),
            home:  const Splash(),
          ),
        );
      },
    );
  }
}

// Apply font to our app's theme
ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.soraTextTheme(
      theme.textTheme,
    ),
  );
}
