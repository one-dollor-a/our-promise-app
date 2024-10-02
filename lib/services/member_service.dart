import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MemberService {
  static final String _baseUrl = dotenv.get('BASE_URL');
  static const storage = FlutterSecureStorage();

  static Future<String?> getMyCode() async {
    try {
      String? token = await storage.read(key: "accessToken");
      final response = await http.get(
        Uri.parse('$_baseUrl/api/v1/members/my/code'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['response']['myCode'];
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}