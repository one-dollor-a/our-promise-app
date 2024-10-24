import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/services/auth.service.dart';

class SignInPage extends ConsumerWidget {
  final _fromKeySignIn = GlobalKey<FormBuilderState>();

  SignInPage({super.key});

  _onPressSignInButton(BuildContext context, WidgetRef ref) async {
    final result = await AuthService.signIn(
      _fromKeySignIn.currentState!.fields['email']!.value as String,
      _fromKeySignIn.currentState!.fields['password']!.value as String,
      ref,
    );
    if (!context.mounted) return;
    if (result == true) {
      return Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Our Promise 로그인',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FormBuilder(
        key: _fromKeySignIn,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '이메일을 입력해주세요.',
                  ),
                  FormBuilderValidators.email(
                    errorText: '이메일 형식이 아닙니다.',
                  ),
                ]),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: '이메일',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffdc4c4), width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '비밀번호를 입력해주세요.',
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: '비밀번호는 8자 이상이어야 합니다.',
                  ),
                ]),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfffdc4c4), width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    if (_fromKeySignIn.currentState!.saveAndValidate()) {
                      _onPressSignInButton(context, ref);
                    }
                  },
                  child: const Text('로그인',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
