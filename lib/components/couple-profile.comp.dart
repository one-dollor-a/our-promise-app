import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/couple-profile.model.dart';
import 'package:our_promise/providers/couple-profile.provider.dart';

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
            _ => _buildCoupleProfile(context, coupleProfile),
          }),
    );
  }

  _buildCoupleProfile(BuildContext context, CoupleProfile coupleProfile) {
    return [
      Text(coupleProfile.name, style: Theme.of(context).textTheme.titleMedium),
      Text(coupleProfile.dDay, style: Theme.of(context).textTheme.titleLarge),
    ];
  }

  _buildNullCoupleProfile(BuildContext context) {
    return [
      Text('커플등록하러가기', style: Theme.of(context).textTheme.titleMedium),
    ];
  }
}
