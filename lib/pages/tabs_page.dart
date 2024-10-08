import 'package:flutter/material.dart';
import 'package:our_promise/components/add_contract_comp.dart';
import 'package:our_promise/components/bottom_navigation_comp.dart';
import 'package:our_promise/pages/contract_page.dart';
import 'package:our_promise/pages/main_page.dart';
import 'package:our_promise/pages/my_profile_page.dart';
import 'package:our_promise/pages/shared_profile_page.dart';

import 'my/my_profile_choice_page.dart';

class TabsPage extends StatefulWidget {
  TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageChanged);
  }

  void _pageChanged() {
    int currentPage = _pageController.page!.round();
    if (currentPage != _currentPageIndex) {
      setState(() {
        _currentPageIndex = currentPage;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageChanged);
    _pageController.dispose();
    super.dispose();
  }

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
              MyProfileChoicePage()
            ],
          ),
        ),
      ),
      floatingActionButton: _currentPageIndex == 1 ? AddContractComp() : null,
    );
  }
}
