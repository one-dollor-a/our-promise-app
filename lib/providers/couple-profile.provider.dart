import 'package:our_promise/models/couple-profile.model.dart';
import 'package:our_promise/services/couple-profile.service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'couple-profile.provider.g.dart';

@riverpod
Future<CoupleProfile> coupleProfile(CoupleProfileRef ref) async {
  final result = CoupleProfileService.getCoupleProfile();
  return result;
}
