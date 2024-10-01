import 'dart:convert'; // JSON 디코딩을 위해 필요

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthService {
  static final String _baseUrl = dotenv.get('BASE_URL');
  // static const String _url = 'https://dummyjson.com/auth';
  static const storage = FlutterSecureStorage();

  static Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'userId': email,
        'password': password,
      });
      print(email);
      print(password);
      print('$_baseUrl/api/v1/auth/sign-in');
      final response = await http.post(
          Uri.parse('$_baseUrl/api/v1/auth/sign-in'),
          body: body,
          headers: headers);

      final responseData =
          json.decode(response.body); // String을 Map<String, dynamic>으로 변환
      print(response.statusCode);
      if (response.statusCode == 200) {
        // 액세스 토큰 저장
        await storage.write(
            key: 'accessToken', value: responseData['response']['accessToken']);
        return true;
      } else {
        Fluttertoast.showToast(msg: "로그인 실패: ${response.body}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "로그인 중 오류 발생: ${e.toString()}");
      return false;
    }
  }

  static Future<bool> signUp(
    String email,
    String password,
    String nickname,
  ) async {
    try {
      // final response = await http.post(Uri.parse('$_url/sign-in'), body: {
      //   'username': email,
      //   'password': password,
      // });
      print(email);
      print(password);
      print(nickname);
      print('$_baseUrl/api/v1/auth/sign-up');

      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'userId': email,
        'password': password,
        'nickName': nickname,
      });

      final response = await http.post(
          Uri.parse('$_baseUrl/api/v1/auth/sign-up'),
          body: body,
          headers: headers);
      // final decodedResponse = utf8.decode(response.bodyBytes);
      final decodedBody = utf8.decode(response.bodyBytes);
      // JSON 파싱
      final responseData = json.decode(decodedBody);
      if (response.statusCode == 201) {
        print('signup response : ${responseData['response']}');
        // 가입 완료
        return true;
      } else {
        Fluttertoast.showToast(msg: "회원가입 실패: ${response.body}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "회원가입 중 오류 발생: ${e.toString()}");
      return false;
    }
  }

  static Future<void> signOut() async {
    await storage.delete(key: 'accessToken');
  }

  static Future<String?> getToken() async {
    String? token = await storage.read(key: "accessToken");
    return token;
  }

  // /api/v1/members/my
  static Future<User> getCurrentUser() async {
    String? accessToken = await getToken();
    print('accessToken : ${accessToken}');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(Uri.parse('$_baseUrl/api/v1/members/my'),
        headers: headers);
    final responseData =
        json.decode(response.body); // String을 Map<String, dynamic>으로 변환
    print(responseData['response']);
    return User.fromJson(responseData['response']);
  }
}
