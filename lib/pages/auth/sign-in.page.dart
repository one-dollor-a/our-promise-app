import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          '로그인',
          style: Theme.of(context).tabBarTheme.labelStyle,
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('로그인 페이지'),
        ),
      ),
    );
  }
}
