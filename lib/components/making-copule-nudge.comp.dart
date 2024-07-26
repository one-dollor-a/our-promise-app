import 'package:flutter/material.dart';

class MakingCoupleNudgeComp extends StatelessWidget {
  const MakingCoupleNudgeComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/disconnect.png'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              backgroundColor: const Color(0xff613e3e),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            Navigator.pushNamed(context, '/connect_couple');
          },
          child: Text(
            '짝꿍 연결하기',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
