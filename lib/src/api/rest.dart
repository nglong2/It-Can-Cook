import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RestApi {
  final String baseUrl = 'https://api.wemealkit.ddns.net';

  Future<http.Response> get(String path) async {
    var token = await getJwtToken();
    final url = Uri.parse('$baseUrl/$path');
    final response = await http.get(url, headers: {
      'Authorization':
          "Bearer $token", // Add Authorization header with JWT token
    });
    return response;
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    var token = await getJwtToken();
    body = encodeMap(body);
    final jsonBody = jsonEncode(body);
    final url = Uri.parse('$baseUrl/$path');
    final response = await http.post(url, body: jsonBody, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer $token", // Add Authorization header with JWT token
    });
    return response;
  }

  //httpput
  Future<http.Response> put(String path, Map<String, dynamic> body) async {
    var token = await getJwtToken();
    final jsonBody = jsonEncode(body);
    final url = Uri.parse('$baseUrl/$path');
    final response = await http.put(url, body: jsonBody, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    });
    return response;
  }

  //httpdelete
  Future<http.Response> delete(String path) async {
    var token = await getJwtToken();
    final url = Uri.parse('$baseUrl/$path');
    final response = await http.delete(url, headers: {
      'Authorization': "Bearer $token",
    });
    return response;
  }

  Future<String> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    //get jwtToken from shared preferences
    final jwtToken = prefs.getString('jwtToken');
    return jwtToken ?? ''; // Return empty string if token is null
  }

  // Add more methods for other HTTP verbs (PUT, DELETE, etc.) as needed

  // Example usage:
  // Future<void> fetchData() async {
  //   final response = await get('data');
  //   if (response.statusCode == 200) {
  //     // Handle successful response
  //   } else {
  //     // Handle error response
  //   }
  // }
}

Map<String, dynamic> encodeMap(Map<String, dynamic> map) {
  map.forEach((key, value) {
    if (value is DateTime) {
      map[key] = value.toString();
    }
    if (value is DateTime?) {
      map[key] = value.toString();
    }
  });
  return map;
}

class OutApi {
  Future<http.Response> get(String path) async {
    final url = Uri.parse(path);
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    body = encodeMap(body);
    final jsonBody = jsonEncode(body);
    final url = Uri.parse(path);
    final response = await http.post(url, body: jsonBody, headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }

  //httpput
  Future<http.Response> put(String path, Map<String, dynamic> body) async {
    final jsonBody = jsonEncode(body);
    final url = Uri.parse(path);
    final response = await http.put(url, body: jsonBody, headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }

  //httpdelete
  Future<http.Response> delete(String path) async {
    final url = Uri.parse(path);
    final response = await http.delete(url);
    return response;
  }

  // Add more methods for other HTTP verbs (PUT, DELETE, etc.) as needed

  // Example usage:
  // Future<void> fetchData() async {
  //   final response = await get('data');
  //   if (response.statusCode == 200) {
  //     // Handle successful response
  //   } else {
  //     // Handle error response
  //   }
  // }
}
