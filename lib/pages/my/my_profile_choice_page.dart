import 'package:flutter/material.dart';

/// 커플 정보 보기 & 짝꿍 정보 보기 선택 화면
class MyProfileChoicePage extends StatelessWidget {
  const MyProfileChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: () {
            Navigator.pushNamed(context, '/my_profile');
          }, child: Text('내 정보 보기', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold,),)),
          const SizedBox(height: 24,),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, '/disconnect_couple');
          }, child: Text('짝꿍 끊기', style: TextStyle(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.bold,),)),
        ],
      ),
    );
  }
}
