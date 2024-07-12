import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          '회원가입',
          style: Theme.of(context).tabBarTheme.labelStyle,
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('회원가입 페이지'),
        ),
      ),
    );
  }
}
