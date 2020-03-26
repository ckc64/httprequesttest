import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ConfirmedCases.dart';

class Services{
  static const String url = "https://coronavirus-ph-api.now.sh/cases";

  static Future<List<ConfirmedCases>> getConfirmedCases() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<ConfirmedCases> list = parseConfirmedCases(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<ConfirmedCases> parseConfirmedCases(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ConfirmedCases>((json) => ConfirmedCases.fromJson(json)).toList();
  }
}