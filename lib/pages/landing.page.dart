import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:our_promise/services/auth.service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  _signIn(BuildContext context) {
    Navigator.pushNamed(context, '/sign-in');
  }

  _signUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  static String? token;

  static const storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTokenThenNavigate();
    });
  }

  _getTokenThenNavigate() async {
    token = await AuthService.getToken();

    if (token != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '사랑을 더욱 특별하게, 커플 계약서',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Image(image: AssetImage('assets/images/logo.png')),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0XFFFDC4C4))),
                  onPressed: () => _signIn(context),
                  child: Text(
                    '로그인',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xFF552B2B)),
                  )),
              TextButton(
                onPressed: () => _signUp(context),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '계정이 없다면 ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: '회원가입하기',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: const Color(0xFFC04F4F)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
