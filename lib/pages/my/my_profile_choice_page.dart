import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth.service.dart';

/// 커플 정보 보기 & 짝꿍 정보 보기 선택 화면
class MyProfileChoicePage extends ConsumerWidget {
  const MyProfileChoicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/my_profile');
              },
              child: const Text(
                '내 정보 보기',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 24,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/disconnect_couple');
              },
              child: const Text(
                '짝꿍 끊기',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 24,
          ),
          TextButton(
              onPressed: () async {
                bool result = await AuthService.logout(ref);
                if (result) {
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/landing', (route) => false);
                }
              },
              child: const Text(
                '로그아웃',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
