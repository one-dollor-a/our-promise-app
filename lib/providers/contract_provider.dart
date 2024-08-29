import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/contract_model.dart';

class ContractNotifier extends Notifier<List<Contract>> {
  @override
  List<Contract> build() {
    return [];
  }

  void setNullCoupleProfile() {
    state = [];
  }

  void setContracts(List<Contract> contracts) {
    state = contracts;
  }
}

final contractProvider = NotifierProvider<ContractNotifier, List<Contract>>(() {
  return ContractNotifier();
});
