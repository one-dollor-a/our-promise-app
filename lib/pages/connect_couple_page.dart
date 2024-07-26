import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ConnectCouplePage extends StatefulWidget {
  const ConnectCouplePage({super.key});

  @override
  State<ConnectCouplePage> createState() => _ConnectCouplePageState();
}

class _ConnectCouplePageState extends State<ConnectCouplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '짝꿍 연결',
          style: TextStyle(fontSize: 20, fontFamily: 'Pretendard'),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffFDC4C4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '짝꿍의 번호를 입력 후\n연결하기 버튼을 눌러주세요 !',
              style: TextStyle(
                fontFamily: 'Pretendard',
                color: Color(0xff410E0B),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              '내 번호 : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              '짝꿍 번호 :',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Color(0xff410E0B),
                  fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 64),
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  hintText: '짝꿍번호를 입력해주세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '짝꿍번호를 입력해주세요';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  // 여기에 done 버튼을 눌렀을 때의 동작을 구현하세요
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 64),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    backgroundColor: const Color(0xff613e3e),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  // todo - 내 코드 복사
                },
                child: Text(
                  '내 코드 복사하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 64),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // todo - 연결 하기
                },
                child: Text(
                  '연결하기',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard'),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
