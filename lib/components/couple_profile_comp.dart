import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/components/making_copule_nudge_comp.dart';
import 'package:our_promise/models/couple_profile_model.dart';
import 'package:our_promise/providers/couple_profile_provider.dart';

import '../models/couple_models.dart';

class CoupleProfileComp extends ConsumerWidget {
  const CoupleProfileComp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupleProfile = ref.watch(coupleProfileProvider);

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: switch (coupleProfile) {
            AsyncData(:final value) => _buildCoupleProfile(context, value),
            AsyncError(:final error) => [Text('오류 발생: $error')],
            _ => [const CircularProgressIndicator()],
          }),
    );
  }

  List<Widget> _buildCoupleProfile(
      BuildContext context, CoupleInfoResponse? coupleProfile) {
    if (coupleProfile == null) {
      return _buildNullCoupleProfile(context);
    }
    return [
      Text(coupleProfile.coupleName,
          style: Theme.of(context).textTheme.titleMedium),
      Text(coupleProfile.coupleSince, style: Theme.of(context).textTheme.titleLarge),
    ];
  }

  _buildNullCoupleProfile(BuildContext context) {
    return [
      const MakingCoupleNudgeComp(),
    ];
  }
}
