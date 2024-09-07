import 'package:flutter_riverpod/flutter_riverpod.dart';

//
class MyProfileChoiceProvider extends StateNotifier<int> {
  int selectedMenuIdx = 0;

  MyProfileChoiceProvider(super.state);

  int get currentMenuIdx => selectedMenuIdx;

  void changeMenuIdx(int menuIdx) {
    selectedMenuIdx = menuIdx;
  }
}