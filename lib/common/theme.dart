import 'package:flutter/material.dart';

ThemeData initThemeData({required Brightness brightness}) {
  if (brightness == Brightness.light) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xffFDC4C4), // 주요 색상
        secondary: Colors.orange, // 보조 색상
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFF552B2B)), // 일반 텍스트
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFF4F4), // 바텀 네비게이션 배경 색
        unselectedLabelStyle:
            TextStyle(color: Colors.black, fontSize: 10), // 라벨 스타일
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF4F4), // 배경색
    );
  } else {
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}
