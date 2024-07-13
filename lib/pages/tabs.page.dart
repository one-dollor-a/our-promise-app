import 'package:flutter/material.dart';
import 'package:our_promise/components/bottom-navigation.comp.dart';
import 'package:our_promise/pages/contract.page.dart';
import 'package:our_promise/pages/main.page.dart';
import 'package:our_promise/pages/my-profile.page.dart';
import 'package:our_promise/pages/shared-profile.page.dart';

class TabsPage extends StatelessWidget {
  final _pageController = PageController();
  TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    ;
  }
}
