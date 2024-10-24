import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/token_model.dart';
import '../services/auth.service.dart';

class AuthNotifier extends StateNotifier<TokenModel?> {
  AuthNotifier() : super(null);

  Future<void> setToken(TokenModel token) async {
    state = token;
    // 토큰 저장
    await AuthService.saveToken(token);
  }

  Future<void> clearToken() async {
    state = null;
    await AuthService.signOut();
  }

  Future<bool> refreshTokenIfNeeded() async {
    if (state == null) return false;

    if (state!.needsRefresh) {
      final newToken = await AuthService.refreshToken();
      if (newToken != null) {
        state = TokenModel.fromJson({'accessToken': newToken});
        return true;
      } else {
        await clearToken();
        return false;
      }
    }
    return true;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, TokenModel?>((ref) {
  return AuthNotifier();
});

// 인증 상태 provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final token = ref.watch(authProvider);
  return token != null && !token.isExpired;
});
