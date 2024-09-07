import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisConnectCouplePage extends ConsumerWidget {
  const DisConnectCouplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/broken.png'),
            Text(
              '짝꿍과 끊어질 경우\n해당 계약서는 없어지며\n코드가 변경됩니다.\n\n정말로 짝꿍을 끊으시겠습니까?',
              style: TextStyle(fontSize: 16, color: Color(0xff410E0B)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              width: double.infinity,
              height: 74,
              margin: EdgeInsets.symmetric(horizontal: 48),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFDC4C4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '돌아가기',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff552B2B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '짝꿍 끊기',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
