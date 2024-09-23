import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:our_promise/models/couple_profile_model.dart';

class CoupleInfoService {
  static final String _url = '${dotenv.get('BASE_URL')}/couple-profile';

  static Future<CoupleProfile?> getCoupleProfile() async {
    try {
      final response = await http.get(Uri.parse(_url));
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
