import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
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
                // 로그아웃 API 호출 및 토큰 삭제
                bool result = await AuthService.logout(ref);
                if (result) {
                  // 로그아웃 성공 시 auth provider의 상태도 초기화
                  await ref.read(authProvider.notifier).clearToken();
                  
                  if (!context.mounted) return;
                  // 랜딩 페이지로 이동
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
