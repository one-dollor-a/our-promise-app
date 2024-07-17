import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:our_promise/models/contract.model.dart';

class ContractService {
  static final String _url = '${dotenv.get('BASE_URL')}/contracts';

  static Future<List<Contract>> getContracts() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final List<dynamic> contracts = json.decode(response.body);
        return contracts
            .map((contract) => Contract.fromJson(contract))
            .toList();
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  static Future<List<Contract>> addContract(String body) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'body': body,
        }),
      );
      if (response.statusCode == 201) {
        final List<dynamic> contracts = json.decode(response.body);
        return contracts
            .map((contract) => Contract.fromJson(contract))
            .toList();
      } else {
        Fluttertoast.showToast(msg: "Error가 발생했습니다.");
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }
}
