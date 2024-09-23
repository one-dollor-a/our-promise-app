import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/couple_profile_model.dart';

class RemoteDataSource {
  final String baseURL = dotenv.get('BASE_URL');
  static const storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    String? token = await storage.read(key: "accessToken");
    return token;
  }

  Future<CoupleProfile?> editCoupleProfile() async {
    String? accessToken = await getToken();
    print('accessToken : $accessToken');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(Uri.parse('$baseURL/couple/info'), headers: headers);
      if (response.statusCode == 200) {
        final CoupleProfile coupleProfile =
        coupleProfileFromJson(response.body);
        return coupleProfile;
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<CoupleProfile?> getCoupleProfile() async {
    // 커플 정보 조회

    String? accessToken = await getToken();
    print('accessToken : $accessToken');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(Uri.parse('$baseURL/couple/info'), headers: headers);
      if (response.statusCode == 200) {
        final CoupleProfile coupleProfile =
        coupleProfileFromJson(response.body);
        return coupleProfile;
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}