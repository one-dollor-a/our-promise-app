import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigationComp extends StatefulWidget {
  final PageController pageController;

  const BottomNavigationComp({
    super.key,
    required this.pageController,
  });

  @override
  State<BottomNavigationComp> createState() => _BottomNavigationCompState();
}

class _BottomNavigationCompState extends State<BottomNavigationComp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      color: Theme.of(context).colorScheme.primary,
      items: <Widget>[
        NavigationItem(
          icon: const Icon(Icons.home_outlined, size: 30),
          title: "홈",
          isSelected: _selectedIndex == 0,
        ),
        NavigationItem(
          icon: const Icon(Icons.bookmark_border, size: 30),
          title: "계약서",
          isSelected: _selectedIndex == 1,
        ),
        NavigationItem(
          icon: const Icon(Icons.favorite_border, size: 30),
          title: "짝꿍",
          isSelected: _selectedIndex == 2,
        ),
        NavigationItem(
          icon: const Icon(Icons.person_outline, size: 30),
          title: "About Me",
          isSelected: _selectedIndex == 3,
        )
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.pageController.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      },
    );
  }
}

class NavigationItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Widget icon;

  static double selectedHeight = 30;
  static double defaultHeight = 50;

  const NavigationItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: isSelected ? 0 : 30),
      height: isSelected ? selectedHeight : defaultHeight,
      child: Column(
        children: [
          icon,
          if (!isSelected)
            Text(title,
                style: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedLabelStyle),
        ],
      ),
    );
  }
}
