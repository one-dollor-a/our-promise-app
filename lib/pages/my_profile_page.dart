import 'package:flutter/material.dart';
import 'package:our_promise/services/auth.service.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  _logout(BuildContext context) async {
    await AuthService.signOut();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('내 프로필 페이지'),
        ElevatedButton(
          onPressed: () async => await _logout(context),
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}
