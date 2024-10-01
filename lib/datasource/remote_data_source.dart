import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/auth_models.dart';
import '../models/couple_models.dart';
import '../models/couple_profile_model.dart';

class RemoteDataSource {
  final String baseURL = dotenv.get('BASE_URL');
  static const storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: "accessToken");
  }

  Map<String, String> _getHeaders(String? token) {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<AuthSignInResponse?> signUp(AuthSignUpRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/v1/auth/sign-up'),
        headers: _getHeaders(null),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        return AuthSignInResponse.fromJson(jsonDecode(response.body));
      } else {
        Fluttertoast.showToast(msg: "회원가입 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "회원가입 중 오류 발생: ${e.toString()}");
      return null;
    }
  }

  Future<AuthSignInResponse?> signIn(AuthSignInRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/v1/auth/sign-in'),
        headers: _getHeaders(null),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final authResponse =
            AuthSignInResponse.fromJson(jsonDecode(response.body));
        await storage.write(
            key: 'accessToken', value: authResponse.accessToken);
        return authResponse;
      } else {
        Fluttertoast.showToast(msg: "로그인 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "로그인 중 오류 발생: ${e.toString()}");
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      String? token = await getToken();
      final response = await http.get(
        Uri.parse('$baseURL/api/v1/auth/logout'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'accessToken');
        return true;
      } else {
        Fluttertoast.showToast(msg: "로그아웃 실패");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "로그아웃 중 오류 발생: ${e.toString()}");
      return false;
    }
  }

  Future<CoupleInfoResponse?> getCoupleInfo() async {
    try {
      String? token = await getToken();
      final response = await http.get(
        Uri.parse('$baseURL/api/v1/couple/info'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        return CoupleInfoResponse.fromJson(jsonDecode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: "커플 정보 조회 실패 (상태 코드: ${response.statusCode})");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "커플 정보 조회 중 오류 발생: ${e.toString()}");
      return null;
    }
  }

  Future<bool> updateCoupleInfo(CoupleInfoUpdateRequest request) async {
    try {
      String? token = await getToken();
      final response = await http.patch(
        Uri.parse('$baseURL/api/v1/couple/info'),
        headers: _getHeaders(token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "커플 정보 수정 실패 (상태 코드: ${response.statusCode})");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "커플 정보 수정 중 오류 발생: ${e.toString()}");
      return false;
    }
  }

  Future<bool> breakupCouple() async {
    try {
      String? token = await getToken();
      final response = await http.patch(
        Uri.parse('$baseURL/api/v1/couple/breakup'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "커플 관계 끊기 실패 (상태 코드: ${response.statusCode})");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "커플 관계 끊기 중 오류 발생: ${e.toString()}");
      return false;
    }
  }

  Future<CoupleInfoSummaryResponse?> getCoupleSummary() async {
    try {
      String? token = await getToken();
      final response = await http.get(
        Uri.parse('$baseURL/api/v1/couple/info/summary'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        return CoupleInfoSummaryResponse.fromJson(jsonDecode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: "커플 요약 정보 조회 실패 (상태 코드: ${response.statusCode})");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "커플 요약 정보 조회 중 오류 발생: ${e.toString()}");
      return null;
    }
  }
}
