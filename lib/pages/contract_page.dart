import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/contract_model.dart';
import 'package:our_promise/providers/contract_provider.dart';
import 'package:our_promise/services/contract.service.dart';

class ContractPage extends ConsumerStatefulWidget {
  const ContractPage({super.key});

  @override
  ConsumerState<ContractPage> createState() => ContractPageState();
}

class ContractPageState extends ConsumerState<ContractPage> {
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
    // Future.microtask(() async {
    //   if (_mounted) {
    //     final contracts = await ContractService.getContracts();
    //     if (_mounted) {
    //       ref.read(contractProvider.notifier).setContracts(contracts);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contracts = ref.watch(contractProvider);

    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(contracts[index].body),
          leading: CircleAvatar(
            radius: 15,
            child: Text(index.toString(), style: const TextStyle(fontSize: 14)),
          ),
          onLongPress: () => {},
        );
      },
    );
  }
}
