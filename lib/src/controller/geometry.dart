import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:it_can_cook/src/models/system/geometry.dart';

class GeometryController {
  // get address from lat long

  Future<GeocodeResponse?> getAddressFromLatLng(double lat, double long) async {
    //model GeocodeResponse
    GeocodeResponse? data = null;

    var key = "20be8f418ad";
    var key1 = "046d9be5b82";
    var key2 = "203ad37663";
    key = key + key1 + key2;
// https://api.geoapify.com/v1/geocode/reverse?lat=10.816406981743569&lon=106.67745985550903&lang=vi&format=json&apiKey=YOUR_API_KEY

    // var res = await http.get(Uri.parse(
    //     "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$long&apiKey=$key"));
    var res = await http.get(Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$long&lang=vi&format=json&apiKey=$key"));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      data = GeocodeResponse.fromJson(json);
    }

    return data;
  }
}
