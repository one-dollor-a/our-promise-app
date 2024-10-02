import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Clipboard를 사용하기 위해 추가
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/member_provider.dart';

class ConnectCouplePage extends ConsumerStatefulWidget {
  const ConnectCouplePage({super.key});

  @override
  ConsumerState<ConnectCouplePage> createState() => _ConnectCouplePageState();
}

class _ConnectCouplePageState extends ConsumerState<ConnectCouplePage> {
  @override
  Widget build(BuildContext context) {
    final myCodeAsyncValue = ref.watch(myCodeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '짝꿍 연결',
          style: TextStyle(fontSize: 22, fontFamily: 'Pretendard', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffFDC4C4),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFDC4C4), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Text(
                    '짝꿍의 코드를 입력 후\n연결하기 버튼을 눌러주세요!', // 여기 변경
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xff410E0B),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: myCodeAsyncValue.when(
                        data: (myCode) => Text(
                          '내 코드: ${myCode ?? "로딩 중..."}', // 여기 변경
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        loading: () => CircularProgressIndicator(),
                        error: (error, _) => Text('오류 발생: $error'),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    '짝꿍 코드', // 여기 변경
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xff410E0B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '짝꿍 코드를 입력해주세요', // 여기 변경
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xffFDC4C4), width: 2),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '짝꿍 코드를 입력해주세요'; // 여기 변경
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      // 여기에 done 버튼을 눌렀을 때의 동작을 구현하세요
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: Color(0xff613e3e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      myCodeAsyncValue.whenData((myCode) {
                        if (myCode != null) {
                          Clipboard.setData(ClipboardData(text: myCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('내 코드가 클립보드에 복사되었습니다.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('코드를 불러오는 중 오류가 발생했습니다.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      '내 코드 복사하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      // todo - 연결 하기
                    },
                    child: Text(
                      '연결하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
