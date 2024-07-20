class GeocodeResponse {
  PlusCode plusCode;
  List<Result> results;
  String status;

  GeocodeResponse(
      {required this.plusCode, required this.results, required this.status});

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) {
    return GeocodeResponse(
      plusCode: PlusCode.fromJson(json['plus_code']),
      results:
          (json['results'] as List).map((i) => Result.fromJson(i)).toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plus_code': plusCode.toJson(),
      'results': results.map((i) => i.toJson()).toList(),
      'status': status,
    };
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json['compound_code'],
      globalCode: json['global_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compound_code': compoundCode,
      'global_code': globalCode,
    };
  }
}

class Result {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  PlusCode? plusCode;
  List<String> types;

  Result({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    this.plusCode,
    required this.types,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      addressComponents: (json['address_components'] as List)
          .map((i) => AddressComponent.fromJson(i))
          .toList(),
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
      placeId: json['place_id'],
      plusCode: json['plus_code'] != null
          ? PlusCode.fromJson(json['plus_code'])
          : null,
      types: (json['types'] as List).map((i) => i as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_components': addressComponents.map((i) => i.toJson()).toList(),
      'formatted_address': formattedAddress,
      'geometry': geometry.toJson(),
      'place_id': placeId,
      'plus_code': plusCode?.toJson(),
      'types': types,
    };
  }
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent(
      {required this.longName, required this.shortName, required this.types});

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'],
      shortName: json['short_name'],
      types: (json['types'] as List).map((i) => i as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long_name': longName,
      'short_name': shortName,
      'types': types,
    };
  }
}

class Geometry {
  Location location;
  String locationType;
  Viewport viewport;
  Bounds? bounds;

  Geometry({
    required this.location,
    required this.locationType,
    required this.viewport,
    this.bounds,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      locationType: json['location_type'],
      viewport: Viewport.fromJson(json['viewport']),
      bounds: json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'location_type': locationType,
      'viewport': viewport.toJson(),
      'bounds': bounds?.toJson(),
    };
  }
}

class Location {
  double lat;
  double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({required this.northeast, required this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}

class Bounds {
  Location northeast;
  Location southwest;

  Bounds({required this.northeast, required this.southwest});

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}
