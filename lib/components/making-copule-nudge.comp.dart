import 'package:flutter/material.dart';

class MakingCoupleNudgeComp extends StatelessWidget {
  const MakingCoupleNudgeComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        '연결된 짝꿍이 없어요!\n짝꿍을 연결 해볼까요?',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height:24,),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
            backgroundColor: Color(0xfffdc4c4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {

        },
        child: Text(
          '짝꿍 연결하기',
          style: TextStyle(
              fontSize: 30,
              color: Color(0xff562b2b),
              fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
