import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/halaman_input_deteksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';
import 'state/deteksi_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DeteksiModel(),
      child: const AgriVisionApp(),
    ),
  );
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<DeteksiModel>().isDarkMode;

    return MaterialApp(
      title: 'AgriVision CNN - 707012400012',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.beranda,
      routes: {
        AppRoutes.beranda: (_) => const KerangkaNavigasi(),
        AppRoutes.tentang: (_) => const HalamanTentang(),
        AppRoutes.inputDeteksi: (_) => const HalamanInputDeteksi(),
      },
    );
  }
}
