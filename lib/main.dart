import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:our_promise/common/theme.dart';
import 'package:our_promise/components/bottom-navigation.comp.dart';
import 'package:our_promise/pages/contract.page.dart';
import 'package:our_promise/pages/main.page.dart';
import 'package:our_promise/pages/my-profile.page.dart';
import 'package:our_promise/pages/shared-profile.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 1번코드
  await dotenv.load(fileName: ".env"); // 2번코드
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: initThemeData(brightness: Brightness.light),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationComp(
          pageController: _pageController,
        ),
        body: SafeArea(
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
}
