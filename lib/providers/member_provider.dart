import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/member_service.dart';

final myCodeProvider = FutureProvider<String?>((ref) async {
  return await MemberService.getMyCode();
});