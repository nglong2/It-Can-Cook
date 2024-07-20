import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:it_can_cook/src/models/system/geometry.dart';

class GeometryController {
  // get address from lat long

  Future<GeocodeResponse?> getAddressFromLatLng(double lat, double long) async {
    //model GeocodeResponse
    var data = null;
    var key = "AIzaSyBdPjjEBKwTg8GX";
    var key1 = "N14OW06mgvr";
    var key2 = "4KI4fMwc";
    key = key + key1 + key2;
    var res = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$key"));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      data = GeocodeResponse.fromJson(json);
    }

    return data;
  }
}
