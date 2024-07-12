import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/components/couple-profile.comp.dart';
import 'package:our_promise/models/couple-profile.model.dart';
import 'package:our_promise/providers/couple-profile.provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CoupleProfile> coupleProfile =
        ref.watch(coupleProfileProvider);
    return Center(
      child: switch (coupleProfile) {
        AsyncData(:final value) => _buildCoupleProfile(value),
        AsyncError(:final error) => Text(error.toString()),
        _ => const CircularProgressIndicator(),
      },
    );
  }

  _buildCoupleProfile(CoupleProfile coupleProfile) {
    if (coupleProfile.id == null) {
      return const Text('no');
    } else {
      return const CoupleProfileComp();
    }
  }
}



// child: coupleProfile.when(
        //   data: (value) {
        //     if (value.id != null) {
        //       // 가정: id가 null이 아닐 때 유효하다고 가정
        //       return Text('name: ${value.name}');
        //     } else {
        //       return Text('no');
        //     }
        //   },
        //   error: (error, stack) => Text(error.toString()),
        //   loading: () => const CircularProgressIndicator(),
        // ),