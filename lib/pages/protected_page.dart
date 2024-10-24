import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class ProtectedPage extends ConsumerWidget {
  final Widget child;

  const ProtectedPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 인증 상태 감시
    ref.listen<bool>(isAuthenticatedProvider, (previous, isAuthenticated) {
      if (!isAuthenticated) {
        // 인증이 풀리면 로그인 페이지로 이동
        Navigator.pushNamedAndRemoveUntil(
            context, '/landing', (route) => false);
      }
    });

    return child;
  }
}
