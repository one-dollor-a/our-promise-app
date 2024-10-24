import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/services/auth.service.dart';

import '../models/user.dart';

class MyProfilePage extends ConsumerStatefulWidget {
  const MyProfilePage({super.key});

  @override
  ConsumerState<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends ConsumerState<MyProfilePage> {
  String _userName = ''; // 회원가입 시 입력했던 이름을 저장할 변수
  String _height = ''; // 키
  String _weight = ''; // 몸무게
  String _birthday = '';
  String _mbti = '';
  String _ringSize = '';
  String _shoeSize = '';
  String _personalColor = '';
  String _favoriteColor = '';
  String _favoriteFood = '';
  String _dislikedFood = '';

  @override
  void initState() {
    super.initState();
    _loadUserName(); // 사용자 이름을 로드하는 메서드 호출
  }

  Future<void> _loadUserName() async {
    User? user = await AuthService.getCurrentUser(ref); // ref 파라미터 추가
    setState(() {
      _userName = user?.nickName ?? ''; // null 안전성 처리 추가
      print('test hongchul : $_userName');
    });
  }

  Future<void> _logout(BuildContext context) async {
    await AuthService.signOut();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
  }

  void _submitProfile() {
    print('이름: $_userName');
    print('키: $_height');
    print('몸무게: $_weight');
    print('생일: $_birthday');
    print('MBTI: $_mbti');
    print('반지 호수: $_ringSize');
    print('발 사이즈: $_shoeSize');
    print('퍼스널 컬러: $_personalColor');
    print('좋아하는 색: $_favoriteColor');
    print('좋아하는 음식: $_favoriteFood');
    print('싫어하는 음식: $_dislikedFood');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이름: $_userName'),
                    const SizedBox(height: 16.0),
                    TextField(
                      decoration: const InputDecoration(labelText: '키 (cm)'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _height = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: '몸무게 (kg)'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _weight = value;
                        });
                      },
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text(
                        '프로필 추가 정보 펼치기',
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                              labelText: '생일',
                              hintStyle: TextStyle(fontSize: 16)),
                          onChanged: (value) {
                            setState(() {
                              _birthday = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'MBTI'),
                          onChanged: (value) {
                            setState(() {
                              _mbti = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: '반지 호수'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _ringSize = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: '발 사이즈'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _shoeSize = value;
                            });
                          },
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(labelText: '퍼스널 컬러'),
                          onChanged: (value) {
                            setState(() {
                              _personalColor = value;
                            });
                          },
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(labelText: '좋아하는 색'),
                          onChanged: (value) {
                            setState(() {
                              _favoriteColor = value;
                            });
                          },
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(labelText: '좋아하는 음식'),
                          onChanged: (value) {
                            setState(() {
                              _favoriteFood = value;
                            });
                          },
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(labelText: '싫어하는 음식'),
                          onChanged: (value) {
                            setState(() {
                              _dislikedFood = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 64,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: _submitProfile,
              child: const Text(
                '프로필 정보 업데이트',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
