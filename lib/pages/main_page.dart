import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/components/couple_profile_comp.dart';
import 'package:our_promise/providers/couple_profile_provider.dart';
import 'package:our_promise/services/couple_info.service.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final isCoupled = ref.read(coupleProfileProvider) != null;
    //
    //   if (isCoupled) {
    //     return;
    //   }
    //
    //   CoupleInfoService.getCoupleProfile().then((coupleProfile) {
    //     if (coupleProfile != null) {
    //       ref.read(coupleProfileProvider.notifier).setCoupleProfile(
    //             coupleProfile.coupleId,
    //             coupleProfile.coupleName,
    //             coupleProfile.coupleSince,
    //           );
    //     } else {
    //       ref.read(coupleProfileProvider.notifier).setNullCoupleProfile();
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CoupleProfileComp());
  }
}
