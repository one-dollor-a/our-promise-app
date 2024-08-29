import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/couple_profile_model.dart';

class CoupleProfileNotifier extends Notifier<CoupleProfile?> {
  @override
  CoupleProfile? build() {
    return null;
  }

  void setNullCoupleProfile() {
    state = null;
  }

  void setCoupleProfile(int id, String name, DateTime firstDate) {
    state = CoupleProfile(
      id: id,
      name: name,
      firstDate: firstDate,
    );
  }
}

final coupleProfileProvider =
    NotifierProvider<CoupleProfileNotifier, CoupleProfile?>(() {
  return CoupleProfileNotifier();
});
