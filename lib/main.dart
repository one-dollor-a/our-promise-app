import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/common/theme.dart';
import 'package:our_promise/pages/auth/sign-in.page.dart';
import 'package:our_promise/pages/auth/sign-up.page.dart';
import 'package:our_promise/pages/landing.page.dart';
import 'package:our_promise/pages/tabs.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/landing': (context) => const LandingPage(),
        '/': (context) => TabsPage(),
      },
      initialRoute: '/landing',
      theme: initThemeData(brightness: Brightness.light),
    );
  }
}
