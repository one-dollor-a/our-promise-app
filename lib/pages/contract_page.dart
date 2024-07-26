import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/providers/contract.provider.dart';
import 'package:our_promise/providers/couple-profile.provider.dart';
import 'package:our_promise/services/contract.service.dart';

class ContractPage extends ConsumerStatefulWidget {
  const ContractPage({super.key});

  @override
  ContractPageState createState() => ContractPageState();
}

class ContractPageState extends ConsumerState<ContractPage> {
  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isCoupled = ref.read(coupleProfileProvider) != null;

      if (!isCoupled) {
        return;
      }

      ContractService.getContracts().then((value) {
        ref.read(contractProvider.notifier).setContracts(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildTest();
  }

  _buildTest() {
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
