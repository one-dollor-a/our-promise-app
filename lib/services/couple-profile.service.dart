import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:our_promise/models/couple-profile.model.dart';

class CoupleProfileService {
  static final String _url = '${dotenv.get('BASE_URL')}/coupleInfo';

  static Future<CoupleProfile> getCoupleProfile() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final CoupleProfile coupleProfile =
            coupleProfileFromJson(response.body);
        return coupleProfile;
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return CoupleProfile(id: 0, name: 'empty', firstDate: DateTime.now());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return CoupleProfile(id: 0, name: 'try-catch', firstDate: DateTime.now());
    }
  }
}
