import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/couple-profile.model.dart';
import 'package:our_promise/providers/couple-profile.provider.dart';

class CoupleProfileComp extends ConsumerWidget {
  const CoupleProfileComp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CoupleProfile> coupleProfile =
        ref.watch(coupleProfileProvider);
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: switch (coupleProfile) {
            AsyncData(:final value) => _buildCoupleProfile(context, value),
            AsyncError(:final error) => [Text(error.toString())],
            _ => [const CircularProgressIndicator()],
          }),
    );
  }

  _buildCoupleProfile(BuildContext context, CoupleProfile coupleProfile) {
    return [
      Text('${coupleProfile.name}',
          style: Theme.of(context).textTheme.titleMedium),
      Text('${coupleProfile.dDay}',
          style: Theme.of(context).textTheme.titleLarge),
    ];
  }
}
