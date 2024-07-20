import 'package:flutter/material.dart';

ThemeData initThemeData({required Brightness brightness}) {
  if (brightness == Brightness.light) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xffFDC4C4), // 주요 색상
        secondary: Color(0xFF552B2B), // 보조 색상
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFF552B2B), fontSize: 18), // 일반 텍스트
        titleMedium: TextStyle(
            color: Color(0xFF552B2B),
            fontSize: 32,
            fontWeight: FontWeight.w700), // 큰 텍스트
        titleLarge: TextStyle(
            color: Color(0xFF552B2B),
            fontSize: 52,
            fontWeight: FontWeight.w700), // 큰 텍스트
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xffFBE6E0), // 바텀 네비게이션 배경 색
        unselectedLabelStyle:
            TextStyle(color: Colors.black, fontSize: 10), // 라벨 스타일
      ),
      scaffoldBackgroundColor: const Color(0xfffff4f4), // 배경색
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(color: Colors.black, fontSize: 14), // 탭 스타일
      ),
    );
  } else {
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}
