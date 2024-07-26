class GeocodeResponse {
  GeocodeResponse({
    required this.type,
    required this.features,
    required this.query,
  });

  final String type;
  final List<Feature> features;
  final Query query;

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) =>
      GeocodeResponse(
        type: json["type"] ?? '',
        features: json["features"] != null
            ? List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x)))
            : [],
        query: json["query"] != null
            ? Query.fromJson(json["query"])
            : Query(lat: 0.0, lon: 0.0, plusCode: ''),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "query": query.toJson(),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
    required this.bbox,
  });

  final String type;
  final Properties properties;
  final Geometry geometry;
  final List<double> bbox;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"] ?? '',
        properties: json["properties"] != null
            ? Properties.fromJson(json["properties"])
            : Properties.defaultProperties(),
        geometry: json["geometry"] != null
            ? Geometry.fromJson(json["geometry"])
            : Geometry(type: '', coordinates: []),
        bbox: json["bbox"] != null
            ? List<double>.from(json["bbox"].map((x) => x.toDouble()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
      };
}

class Properties {
  Properties({
    required this.datasource,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.state,
    required this.city,
    required this.postcode,
    required this.district,
    required this.suburb,
    required this.street,
    required this.housenumber,
    required this.lon,
    required this.lat,
    required this.stateCode,
    required this.distance,
    required this.resultType,
    required this.formatted,
    required this.addressLine1,
    required this.addressLine2,
    required this.category,
    required this.timezone,
    required this.plusCode,
    required this.rank,
    required this.placeId,
  });

  final Datasource datasource;
  final String name;
  final String country;
  final String countryCode;
  final String state;
  final String city;
  final String postcode;
  final String district;
  final String suburb;
  final String street;
  final String housenumber;
  final double lon;
  final double lat;
  final String stateCode;
  final int distance;
  final String resultType;
  final String formatted;
  final String addressLine1;
  final String addressLine2;
  final String category;
  final Timezone timezone;
  final String plusCode;
  final Rank rank;
  final String placeId;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        datasource: json["datasource"] != null
            ? Datasource.fromJson(json["datasource"])
            : Datasource.defaultDatasource(),
        name: json["name"] ?? '',
        country: json["country"] ?? '',
        countryCode: json["country_code"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
        postcode: json["postcode"] ?? '',
        district: json["district"] ?? '',
        suburb: json["suburb"] ?? '',
        street: json["street"] ?? '',
        housenumber: json["housenumber"] ?? '',
        lon: json["lon"]?.toDouble() ?? 0.0,
        lat: json["lat"]?.toDouble() ?? 0.0,
        stateCode: json["state_code"] ?? '',
        distance: json["distance"] ?? 0,
        resultType: json["result_type"] ?? '',
        formatted: json["formatted"] ?? '',
        addressLine1: json["address_line1"] ?? '',
        addressLine2: json["address_line2"] ?? '',
        category: json["category"] ?? '',
        timezone: json["timezone"] != null
            ? Timezone.fromJson(json["timezone"])
            : Timezone.defaultTimezone(),
        plusCode: json["plus_code"] ?? '',
        rank: json["rank"] != null
            ? Rank.fromJson(json["rank"])
            : Rank(importance: 0.0, popularity: 0.0),
        placeId: json["place_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "datasource": datasource.toJson(),
        "name": name,
        "country": country,
        "country_code": countryCode,
        "state": state,
        "city": city,
        "postcode": postcode,
        "district": district,
        "suburb": suburb,
        "street": street,
        "housenumber": housenumber,
        "lon": lon,
        "lat": lat,
        "state_code": stateCode,
        "distance": distance,
        "result_type": resultType,
        "formatted": formatted,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "category": category,
        "timezone": timezone.toJson(),
        "plus_code": plusCode,
        "rank": rank.toJson(),
        "place_id": placeId,
      };

  static Properties defaultProperties() {
    return Properties(
      datasource: Datasource.defaultDatasource(),
      name: '',
      country: '',
      countryCode: '',
      state: '',
      city: '',
      postcode: '',
      district: '',
      suburb: '',
      street: '',
      housenumber: '',
      lon: 0.0,
      lat: 0.0,
      stateCode: '',
      distance: 0,
      resultType: '',
      formatted: '',
      addressLine1: '',
      addressLine2: '',
      category: '',
      timezone: Timezone.defaultTimezone(),
      plusCode: '',
      rank: Rank(importance: 0.0, popularity: 0.0),
      placeId: '',
    );
  }
}

class Datasource {
  Datasource({
    required this.sourcename,
    required this.attribution,
    required this.license,
    required this.url,
  });

  final String sourcename;
  final String attribution;
  final String license;
  final String url;

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
        sourcename: json["sourcename"] ?? '',
        attribution: json["attribution"] ?? '',
        license: json["license"] ?? '',
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "sourcename": sourcename,
        "attribution": attribution,
        "license": license,
        "url": url,
      };

  static Datasource defaultDatasource() {
    return Datasource(
      sourcename: '',
      attribution: '',
      license: '',
      url: '',
    );
  }
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] ?? '',
        coordinates: json["coordinates"] != null
            ? List<double>.from(json["coordinates"].map((x) => x.toDouble()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Rank {
  Rank({
    required this.importance,
    required this.popularity,
  });

  final double importance;
  final double popularity;

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        importance: json["importance"]?.toDouble() ?? 0.0,
        popularity: json["popularity"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "importance": importance,
        "popularity": popularity,
      };
}

class Timezone {
  Timezone({
    required this.name,
    required this.offsetStd,
    required this.offsetStdSeconds,
    required this.offsetDst,
    required this.offsetDstSeconds,
    required this.abbreviationStd,
    required this.abbreviationDst,
  });

  final String name;
  final String offsetStd;
  final int offsetStdSeconds;
  final String offsetDst;
  final int offsetDstSeconds;
  final String abbreviationStd;
  final String abbreviationDst;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        name: json["name"] ?? '',
        offsetStd: json["offset_STD"] ?? '',
        offsetStdSeconds: json["offset_STD_seconds"] ?? 0,
        offsetDst: json["offset_DST"] ?? '',
        offsetDstSeconds: json["offset_DST_seconds"] ?? 0,
        abbreviationStd: json["abbreviation_STD"] ?? '',
        abbreviationDst: json["abbreviation_DST"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "offset_STD": offsetStd,
        "offset_STD_seconds": offsetStdSeconds,
        "offset_DST": offsetDst,
        "offset_DST_seconds": offsetDstSeconds,
        "abbreviation_STD": abbreviationStd,
        "abbreviation_DST": abbreviationDst,
      };

  static Timezone defaultTimezone() {
    return Timezone(
      name: '',
      offsetStd: '',
      offsetStdSeconds: 0,
      offsetDst: '',
      offsetDstSeconds: 0,
      abbreviationStd: '',
      abbreviationDst: '',
    );
  }
}

class Query {
  Query({
    required this.lat,
    required this.lon,
    required this.plusCode,
  });

  final double lat;
  final double lon;
  final String plusCode;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        lat: json["lat"]?.toDouble() ?? 0.0,
        lon: json["lon"]?.toDouble() ?? 0.0,
        plusCode: json["plus_code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "plus_code": plusCode,
      };
}
