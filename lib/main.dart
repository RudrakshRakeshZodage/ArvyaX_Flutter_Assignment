import 'package:arvyax_flutter_assignment/core/theme/app_theme.dart';
import 'package:arvyax_flutter_assignment/data/models/journal_entry_model.dart';
import 'package:arvyax_flutter_assignment/features/ambience/presentation/home_screen.dart';
import 'package:arvyax_flutter_assignment/shared/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryModelAdapter());
  
  runApp(
    const ProviderScope(
      child: ArvyaXApp(),
    ),
  );
}

class ArvyaXApp extends StatefulWidget {
  const ArvyaXApp({super.key});

  @override
  State<ArvyaXApp> createState() => _ArvyaXAppState();
}

class _ArvyaXAppState extends State<ArvyaXApp> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          onInitializationComplete: () => setState(() => _initialized = true),
        ),
      );
    }

    return MaterialApp(
      title: 'ArvyaX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Scaffold(
            body: Center(
              child: SelectableText(
                'UI Error: ${details.exception}\n${details.stack}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        };
        return child!;
      },
      home: const HomeScreen(),
    );
  }
}
