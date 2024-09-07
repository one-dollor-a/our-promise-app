import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/common/theme.dart';
import 'package:our_promise/pages/auth/sign_in_page.dart';
import 'package:our_promise/pages/auth/sign-up_page.dart';
import 'package:our_promise/pages/auth/landing_page.dart';
import 'package:our_promise/pages/connect_couple_page.dart';
import 'package:our_promise/pages/my/disconnect_couple_page.dart';
import 'package:our_promise/pages/my_profile_page.dart';
import 'package:our_promise/pages/tabs_page.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/landing': (context) => const LandingPage(),
        '/disconnect_couple': (context) => const DisConnectCouplePage(),
        '/connect_couple': (context) => const ConnectCouplePage(),
        '/my_profile': (context) => const MyProfilePage(),
        '/': (context) => TabsPage(),
      },
      initialRoute: '/landing',
      theme: initThemeData(brightness: Brightness.light),
    );
  }
}
