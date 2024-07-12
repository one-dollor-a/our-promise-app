import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/common/theme.dart';
import 'package:our_promise/components/bottom-navigation.comp.dart';
import 'package:our_promise/pages/auth/sign-in.page.dart';
import 'package:our_promise/pages/auth/sign-up.page.dart';
import 'package:our_promise/pages/contract.page.dart';
import 'package:our_promise/pages/landing.page.dart';
import 'package:our_promise/pages/main.page.dart';
import 'package:our_promise/pages/my-profile.page.dart';
import 'package:our_promise/pages/shared-profile.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 1번코드
  await dotenv.load(fileName: ".env"); // 2번코드
  runApp(
    ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _pageController = PageController();
  final auth = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
        },
        theme: initThemeData(brightness: Brightness.light),
        home: switch (auth) {
          true => _buildMain(),
          false => _buildLanding(),
        });
  }

  _buildMain() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComp(
        pageController: _pageController,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            children: const <Widget>[
              MainPage(),
              ContractPage(),
              SharedProfilePage(),
              MyProfilePage()
            ],
          ),
        ),
      ),
    );
  }

  _buildLanding() {
    return const LandingPage();
  }
}
