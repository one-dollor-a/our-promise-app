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
import 'package:our_promise/pages/protected_page.dart';
import 'package:our_promise/providers/auth_provider.dart';
import 'package:our_promise/services/auth.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final savedToken = await AuthService.loadToken();
    if (savedToken != null) {
      await ref.read(authProvider.notifier).setToken(savedToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/landing': (context) => const LandingPage(),
        '/disconnect_couple': (context) => const ProtectedPage(
              child: DisConnectCouplePage(),
            ),
        '/connect_couple': (context) => const ProtectedPage(
              child: ConnectCouplePage(),
            ),
        '/my_profile': (context) => const ProtectedPage(
              child: MyProfilePage(),
            ),
        '/': (context) => ProtectedPage(
              child: TabsPage(),
            ),
      },
      initialRoute: '/landing',
      theme: initThemeData(brightness: Brightness.light),
    );
  }
}
