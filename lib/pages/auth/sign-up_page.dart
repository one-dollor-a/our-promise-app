import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:our_promise/services/auth.service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fromKeySignUp = GlobalKey<FormBuilderState>();
  String? _password = "";

  _onPressSignUpButton(BuildContext context) async {
    final result = await AuthService.signUp(
      _fromKeySignUp.currentState!.fields['email']!.value as String,
      _fromKeySignUp.currentState!.fields['password']!.value as String,
      _fromKeySignUp.currentState!.fields['nickname']!.value as String,
    );
    if (!context.mounted) return;


    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('가입이 완료되었습니다 로그인을 해주세요 !')));
      // return Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      Navigator.pop(context);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('가입에 실패 했습니다')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Our Promise 가입하기',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FormBuilder(
        key: _fromKeySignUp,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(
                height: 48,
              ),
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
                decoration: const InputDecoration(labelText: '이메일'),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '패스워드를 입력해주세요.',
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: '패스워드는 8자 이상이어야 합니다.',
                  )
                ]),
                decoration: const InputDecoration(labelText: '패스워드'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'passwordConfirm',
                obscureText: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.equal(
                    _password!,
                    errorText: '패스워드가 일치하지 않습니다.',
                  ),
                ]),
                decoration: const InputDecoration(labelText: '패스워드 확인'),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'nickname',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '닉네임을 입력해주세요.',
                  ),
                ]),
                decoration: const InputDecoration(labelText: '닉네임'),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  if (_fromKeySignUp.currentState!.saveAndValidate()) {
                    _onPressSignUpButton(context);
                  }
                },
                child: const Text('회원가입', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
