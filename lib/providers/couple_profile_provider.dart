import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/couple_profile_model.dart';
import 'package:our_promise/repositories/couple_info_repo.dart';

import '../models/couple_models.dart';

class CoupleProfileNotifier extends AsyncNotifier<CoupleInfoResponse?> {
  late final CoupleInfoRepository _repository;
  @override
  Future<CoupleInfoResponse?> build() async {
    _repository = ref.read(coupleInfoRepositoryProvider);
    return await _repository.getCoupleProfile();
  }

  Future<void> setCoupleProfile(int coupleId, String coupleName, DateTime coupleSince, String coupleProfileImageUrl, int partnerMemberId, String myNickname, String partnerNickname) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {

      var coupleInfoObj = CoupleProfile(
        coupleId: coupleId,
        coupleName: coupleName,
        coupleSince: coupleSince,
        coupleProfileImageUrl: '',
        partnerMemberId: partnerMemberId,
        myNickname: myNickname,
        partnerNickname: partnerNickname,
      );

      _repository.setCoupleProfile(coupleInfoObj);
    });

    if (state.hasError) {
      print(state.error);
    }
  }
}

final coupleProfileProvider =
    AsyncNotifierProvider<CoupleProfileNotifier, CoupleInfoResponse?>(() {
  return CoupleProfileNotifier();
});
