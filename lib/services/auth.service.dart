import 'dart:convert'; // JSON 디코딩을 위해 필요

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // static final String _url = '${dotenv.get('BASE_URL')}';
  static const String _url = 'https://dummyjson.com/auth/login';
  static const storage = FlutterSecureStorage();
  static Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
      // final response = await http.post(Uri.parse('$_url/sign-in'), body: {
      //   'username': email,
      //   'password': password,
      // });

      final response = await http.post(Uri.parse(_url), body: {
        'username': 'emilys',
        'password': 'emilyspass',
      });

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body); // String을 Map<String, dynamic>으로 변환

        await storage.write(key: 'accessToken', value: responseData['token']);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
}
