import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/components/making_copule_nudge_comp.dart';
import 'package:our_promise/models/couple_profile_model.dart';
import 'package:our_promise/providers/couple_profile_provider.dart';

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
            null => _buildNullCoupleProfile(context),
            _ => _buildCoupleProfile(context, coupleProfile.value!),
          }),
    );
  }

  _buildCoupleProfile(BuildContext context, CoupleProfile coupleProfile) {
    return [
      Text(coupleProfile.coupleName, style: Theme.of(context).textTheme.titleMedium),
      Text(coupleProfile.dDay, style: Theme.of(context).textTheme.titleLarge),
    ];
  }

  _buildNullCoupleProfile(BuildContext context) {
    return [
      const MakingCoupleNudgeComp(),
    ];
  }
}