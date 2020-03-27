import 'package:http/http.dart' as http;
import 'package:httprequestapi/LockdownCities.dart';
import 'dart:convert';

import 'ConfirmedCases.dart';

class ServicesConfirmedCases{
  static const String urlConfirmedCases = "https://coronavirus-ph-api.now.sh/cases";
 


//for confirmed cases
  static Future<List<ConfirmedCases>> getConfirmedCases() async {
    try {
      final response = await http.get(urlConfirmedCases);
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

  //end of confirmed cases


}

class ServicesLockdownCities{

 static const String urlLockDownCities = "https://coronavirus-ph-api.now.sh/lockdowns";

    static Future<List<LockdownCities>> getLockedDownCities() async {
    try {
      final response = await http.get(urlLockDownCities);
      if (response.statusCode == 200) {
        List<LockdownCities> list = parseLockedDownCities(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<LockdownCities> parseLockedDownCities(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<LockdownCities>((json) => LockdownCities.fromJson(json)).toList();
  }
 

}