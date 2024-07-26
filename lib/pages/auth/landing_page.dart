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
                style: TextStyle(fontSize: 20, color: Color(0xffBEA7A7)),
              ),
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(height: 64,),
              SizedBox(
                width: 180,
                height: 50,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0XFFFFDCDC))),
                  onPressed: () => _signIn(context),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff562525),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextButton(
                onPressed: () => _signUp(context),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '계정이 없다면? ',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      TextSpan(
                        text: '회원가입하기',
                        style: TextStyle(fontSize: 15, color: Color(0xffc04f4f)),
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
