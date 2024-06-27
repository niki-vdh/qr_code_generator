import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_generator/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_code_generator/screens/qr_code_generator.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('nl', 'BE'),
        Locale('fr', 'FR'),
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Download QR Code Example",
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: connectiveBlue,
        textTheme: GoogleFonts.sourceSans3TextTheme(),
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all<bool>(true),
          trackVisibility: WidgetStateProperty.all<bool>(true),
          thumbColor: WidgetStateProperty.all<Color>(textGrey),
          trackColor: WidgetStateProperty.all<Color>(secureGrey),
          trackBorderColor: WidgetStateProperty.all<Color>(Colors.transparent),
          thickness: WidgetStateProperty.all<double>(13.0),
          radius: Radius.zero,
        ),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      home: const QrCodeGenerator(),
      // home: const QrCodeErrorScreen(),
    );
  }
}
