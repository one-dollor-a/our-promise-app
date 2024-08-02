import 'package:flutter/material.dart';
import 'package:our_promise/services/auth.service.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
    final user = await AuthService.getCurrentUser(); // 현재 사용자 정보 가져오기
    if (user != null) {
      setState(() {
        _userName = user.name; // 사용자 이름 설정
      });
    }
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
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 16.0),
          ExpansionTile(
            title: const Text('추가 정보'),
            children: [
              TextField(
                decoration: const InputDecoration(labelText: '생일'),
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
                decoration: const InputDecoration(labelText: '퍼스널 컬러'),
                onChanged: (value) {
                  setState(() {
                    _personalColor = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: '좋아하는 색'),
                onChanged: (value) {
                  setState(() {
                    _favoriteColor = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: '좋아하는 음식'),
                onChanged: (value) {
                  setState(() {
                    _favoriteFood = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: '싫어하는 음식'),
                onChanged: (value) {
                  setState(() {
                    _dislikedFood = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitProfile,
            child: const Text('작성완료'),
          ),
        ],
      ),
    );
  }
}
