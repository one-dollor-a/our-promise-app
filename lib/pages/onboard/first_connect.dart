import 'package:flutter/material.dart';

/// 최초에 로그인 성공 시
class FirstConnect extends StatefulWidget {
  const FirstConnect({super.key});

  @override
  State<FirstConnect> createState() => _FirstConnectState();
}

class _FirstConnectState extends State<FirstConnect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/images/disconnect.png')),
          const Text(
            '연결된 짝꿍이 없어요!\n짝꿍을 연결 해볼까요?',
            style: TextStyle(
                fontSize: 30,
                color: Color(0xff825c5c),
                fontFamily: 'Pretendard'),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Color(0xfffdc4c4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              Navigator.pushNamed(context, '/connect_couple');
            },
            child: Text(
              '짝꿍 연결하기',
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff562b2b),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
