import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFriend = false;  // 짝꿍 상태를 저장하는 변수
  final String _partnerName = '상대 이름';  // 상대방 이름

  void _toggleFriendStatus() {
    setState(() {
      _isFriend = !_isFriend;
      if (_isFriend) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$_partnerName 님과 짝꿍이 되었습니다!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://i.postimg.cc/wvs6M7ds/image.png',
                  height: 50,
                ),
                const SizedBox(height: 10),
                Text('짝꿍과 끊어질 경우 해당 계약서는 없어지며 코드가 변경됩니다. 정말로 $_partnerName 님과 짝꿍을 끊으시겠습니까?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 돌아가기 버튼을 눌렀을 때 첫 화면으로 돌아가기
                  },
                  child: const Text('돌아가기'),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '짝꿍 정보 확인',
          style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w400, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isFriend ? _buildFriendInfo() : _buildNoFriendInfo(context),
    );
  }

  Widget _buildFriendInfo() {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        // Section 1 - Profile Picture Wrapper
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: GestureDetector(
            onTap: () {
              print('짝꿍 프로필 사진 클릭');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                    // 상대 프로필 사진
                    image: const DecorationImage(image: AssetImage('assets/images/profile.png'), fit: BoxFit.cover),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '짝꿍 프로필 사진',
                      style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/icons/camera.svg', color: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ),
        // Section 2 - 상대 정보 Wrapper
        Container(
          margin: const EdgeInsets.only(top: 24),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInfoTile(
                margin: EdgeInsets.only(bottom: 16),
                label: '이메일',
                value: 'otheruser@example.com',
              ),
              UserInfoTile(
                margin: const EdgeInsets.only(bottom: 16),
                label: '이름',
                value: _partnerName,
              ),

              Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _toggleFriendStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFriend ? Colors.red : Colors.blue,  // 버튼 색상 변경
                  ),
                  child: Text(
                    _isFriend ? '짝꿍 해제' : '짝꿍 맺기',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoFriendInfo(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '연결된 짝꿍이 없어요!\n짝꿍을 연결 해볼까요?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectCouplePage()),
              );
            },
            child: const Text('짝꿍 연결하기'),
          ),
        ],
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const UserInfoTile({Key? key, required this.margin, required this.label, required this.value, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w600, fontSize: 14)),
            Text(value, style: const TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w400, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// connect_couple_page.dart
class ConnectCouplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Couple Page'),
      ),
      body: const Center(
        child: Text('This is the Connect Couple Page.'),
      ),
    );
  }
}
