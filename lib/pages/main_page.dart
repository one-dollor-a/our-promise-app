import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/components/couple-profile.comp.dart';
import 'package:our_promise/providers/couple-profile.provider.dart';
import 'package:our_promise/services/couple-profile.service.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isCoupled = ref.read(coupleProfileProvider) != null;

      if (isCoupled) {
        return;
      }

      CoupleProfileService.getCoupleProfile().then((coupleProfile) {
        if (coupleProfile != null) {
          ref.read(coupleProfileProvider.notifier).setCoupleProfile(
                coupleProfile.id,
                coupleProfile.name,
                coupleProfile.firstDate,
              );
        } else {
          ref.read(coupleProfileProvider.notifier).setNullCoupleProfile();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CoupleProfileComp());
  }
}
