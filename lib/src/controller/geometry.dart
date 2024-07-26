import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:it_can_cook/src/models/system/geometry.dart';

class GeometryController {
  // get address from lat long

  Future<GeocodeResponse?> getAddressFromLatLng(double lat, double long) async {
    //model GeocodeResponse
    var data = null;

    var key = "20be8f418ad";
    var key1 = "046d9be5b82";
    var key2 = "203ad37663";
    key = key + key1 + key2;

    var res = await http.get(Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$long&apiKey=$key"));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      data = GeocodeResponse.fromJson(json);
    }

    return data;
  }
}
