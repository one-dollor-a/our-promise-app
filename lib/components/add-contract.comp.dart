import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:our_promise/providers/contract.provider.dart';
import 'package:our_promise/services/contract.service.dart';

class AddContractComp extends ConsumerStatefulWidget {
  const AddContractComp({super.key});

  @override
  AddContractCompState createState() => AddContractCompState();
}

class AddContractCompState extends ConsumerState<AddContractComp> {
  final _fromKeyAddContract = GlobalKey<FormBuilderState>();

  _onPressAddContractButton(BuildContext context) async {
    final contracts = await ContractService.addContract(
      _fromKeyAddContract.currentState!.fields['body']!.value as String,
    );
    if (!context.mounted) return;
    ref.read(contractProvider.notifier).setContracts(contracts);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('계약 추가', style: TextStyle(fontSize: 20)),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 200,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    child: FormBuilder(
                      key: _fromKeyAddContract,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FormBuilderTextField(
                            name: 'body',
                            minLines: 1,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: '내용을 입력해주세요.',
                              ),
                            ]),
                            decoration: const InputDecoration(labelText: '내용'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_fromKeyAddContract.currentState!
                                  .saveAndValidate()) {
                                _onPressAddContractButton(context);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('저장'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
