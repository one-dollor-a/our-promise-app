import 'dart:convert'; // JSON 디코딩을 위해 필요

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart'; // riverpod 대신 flutter_riverpod으로 변경

import '../models/user.dart';
import '../models/token_model.dart';
import '../providers/auth_provider.dart';

class AuthService {
  static final String _baseUrl = dotenv.get('BASE_URL');
  // static const String _url = 'https://dummyjson.com/auth';
  static const storage = FlutterSecureStorage();

  // 토큰 재발급 메서드
  static Future<String?> refreshToken() async {
    try {
      String? token = await getToken();
      if (token == null) return null;

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v1/auth/refresh'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final newToken = responseData['accessToken'];
        await storage.write(key: 'accessToken', value: newToken);
        return newToken;
      } else {
        // 리프레시 토큰도 만료된 경우
        await signOut(); // 로그아웃 처리
        return null;
      }
    } catch (e) {
      print('토큰 재발급 중 오류 발생: ${e.toString()}');
      return null;
    }
  }

  // HTTP 요청을 보내는 공통 메서드
  static Future<http.Response?> authenticatedRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    Object? body,
    required WidgetRef ref, // Ref -> WidgetRef로 변경
  }) async {
    try {
      final token = ref.read(authProvider)?.accessToken;
      if (token == null) return null;

      final Map<String, String> defaultHeaders = {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };

      headers?.forEach((key, value) {
        defaultHeaders[key] = value;
      });

      http.Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: defaultHeaders);
          break;
        case 'POST':
          response = await http.post(Uri.parse(url),
              headers: defaultHeaders, body: body);
          break;
        case 'PUT':
          response = await http.put(Uri.parse(url),
              headers: defaultHeaders, body: body);
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      // 토큰 만료 체크 (401 Unauthorized)
      if (response.statusCode == 401) {
        final newToken = await refreshToken();
        if (newToken != null) {
          // 새 토큰으로 재시도
          defaultHeaders['Authorization'] = 'Bearer $newToken';
          switch (method.toUpperCase()) {
            case 'GET':
              response =
                  await http.get(Uri.parse(url), headers: defaultHeaders);
              break;
            case 'POST':
              response = await http.post(Uri.parse(url),
                  headers: defaultHeaders, body: body);
              break;
            case 'PUT':
              response = await http.put(Uri.parse(url),
                  headers: defaultHeaders, body: body);
              break;
            case 'DELETE':
              response =
                  await http.delete(Uri.parse(url), headers: defaultHeaders);
              break;
          }
        }
      }

      return response;
    } catch (e) {
      print('HTTP 요청 중 오류 발생: ${e.toString()}');
      return null;
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
  static Future<User?> getCurrentUser(WidgetRef ref) async {
    // Ref -> WidgetRef로 변경
    final response = await authenticatedRequest(
      '$_baseUrl/api/v1/members/my',
      'GET',
      ref: ref,
    );

    if (response != null && response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return User.fromJson(responseData['response']);
    }
    return null;
  }

  static Future<bool> logout(WidgetRef ref) async {
    // Ref -> WidgetRef로 변경
    final response = await authenticatedRequest(
      '$_baseUrl/api/v1/auth/logout',
      'GET',
      ref: ref,
    );

    if (response != null && response.statusCode == 200) {
      await signOut();
      return true;
    }
    Fluttertoast.showToast(msg: "로그아웃 실패");
    return false;
  }

  static Future<void> saveToken(TokenModel token) async {
    await storage.write(key: 'accessToken', value: token.accessToken);
    await storage.write(
        key: 'tokenExpiry', value: token.expiresAt.toIso8601String());
  }

  static Future<TokenModel?> loadToken() async {
    final token = await storage.read(key: 'accessToken');
    final expiry = await storage.read(key: 'tokenExpiry');

    if (token != null && expiry != null) {
      return TokenModel(
        accessToken: token,
        expiresAt: DateTime.parse(expiry),
      );
    }
    return null;
  }

  static Future<bool> signIn(
    String email,
    String password,
    WidgetRef ref, // Ref -> WidgetRef로 변경
  ) async {
    try {
      final body = jsonEncode({
        'userId': email,
        'password': password,
      });

      final response = await http.post(
        Uri.parse('$_baseUrl/api/v1/auth/sign-in'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = TokenModel.fromJson({
          'accessToken': responseData['response']['accessToken'],
        });
        await ref.read(authProvider.notifier).setToken(token);
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
}
