class GeocodeResponse {
  final List<Result> results;
  final Query query;

  GeocodeResponse({required this.results, required this.query});

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) {
    return GeocodeResponse(
      results:
          (json['results'] as List).map((i) => Result.fromJson(i)).toList(),
      query: Query.fromJson(json['query']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((i) => i.toJson()).toList(),
      'query': query.toJson(),
    };
  }
}

class Result {
  final DataSource? datasource;
  final String? name;
  final String? country;
  final String? countryCode;
  final String? city;
  final String? postcode;
  final String? suburb;
  final String? quarter;
  final String? street;
  final double? lon;
  final double? lat;
  final int? distance;
  final String? resultType;
  final String? formatted;
  final String? addressLine1;
  final String? addressLine2;
  final String? category;
  final Timezone? timezone;
  final String? plusCode;
  final Rank? rank;
  final String? placeId;
  final Bbox? bbox;

  Result({
    this.datasource,
    this.name,
    this.country,
    this.countryCode,
    this.city,
    this.postcode,
    this.suburb,
    this.quarter,
    this.street,
    this.lon,
    this.lat,
    this.distance,
    this.resultType,
    this.formatted,
    this.addressLine1,
    this.addressLine2,
    this.category,
    this.timezone,
    this.plusCode,
    this.rank,
    this.placeId,
    this.bbox,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      datasource: json['datasource'] != null
          ? DataSource.fromJson(json['datasource'])
          : null,
      name: json['name'],
      country: json['country'],
      countryCode: json['country_code'],
      city: json['city'],
      postcode: json['postcode'],
      suburb: json['suburb'],
      quarter: json['quarter'],
      street: json['street'],
      lon: json['lon'],
      lat: json['lat'],
      distance: json['distance'],
      resultType: json['result_type'],
      formatted: json['formatted'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      category: json['category'],
      timezone:
          json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null,
      plusCode: json['plus_code'],
      rank: json['rank'] != null ? Rank.fromJson(json['rank']) : null,
      placeId: json['place_id'],
      bbox: json['bbox'] != null ? Bbox.fromJson(json['bbox']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datasource': datasource?.toJson(),
      'name': name,
      'country': country,
      'country_code': countryCode,
      'city': city,
      'postcode': postcode,
      'suburb': suburb,
      'quarter': quarter,
      'street': street,
      'lon': lon,
      'lat': lat,
      'distance': distance,
      'result_type': resultType,
      'formatted': formatted,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'category': category,
      'timezone': timezone?.toJson(),
      'plus_code': plusCode,
      'rank': rank?.toJson(),
      'place_id': placeId,
      'bbox': bbox?.toJson(),
    };
  }
}

class DataSource {
  final String? sourcename;
  final String? attribution;
  final String? license;
  final String? url;

  DataSource({this.sourcename, this.attribution, this.license, this.url});

  factory DataSource.fromJson(Map<String, dynamic> json) {
    return DataSource(
      sourcename: json['sourcename'],
      attribution: json['attribution'],
      license: json['license'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourcename': sourcename,
      'attribution': attribution,
      'license': license,
      'url': url,
    };
  }
}

class Timezone {
  final String? name;
  final String? offsetSTD;
  final int? offsetSTDSeconds;
  final String? offsetDST;
  final int? offsetDSTSeconds;

  Timezone({
    this.name,
    this.offsetSTD,
    this.offsetSTDSeconds,
    this.offsetDST,
    this.offsetDSTSeconds,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      name: json['name'],
      offsetSTD: json['offset_STD'],
      offsetSTDSeconds: json['offset_STD_seconds'],
      offsetDST: json['offset_DST'],
      offsetDSTSeconds: json['offset_DST_seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'offset_STD': offsetSTD,
      'offset_STD_seconds': offsetSTDSeconds,
      'offset_DST': offsetDST,
      'offset_DST_seconds': offsetDSTSeconds,
    };
  }
}

class Rank {
  final double? importance;
  final double? popularity;

  Rank({this.importance, this.popularity});

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      importance: json['importance'],
      popularity: json['popularity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'importance': importance,
      'popularity': popularity,
    };
  }
}

class Bbox {
  final double? lon1;
  final double? lat1;
  final double? lon2;
  final double? lat2;

  Bbox({this.lon1, this.lat1, this.lon2, this.lat2});

  factory Bbox.fromJson(Map<String, dynamic> json) {
    return Bbox(
      lon1: json['lon1'],
      lat1: json['lat1'],
      lon2: json['lon2'],
      lat2: json['lat2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon1': lon1,
      'lat1': lat1,
      'lon2': lon2,
      'lat2': lat2,
    };
  }
}

class Query {
  final double? lat;
  final double? lon;
  final String? plusCode;

  Query({this.lat, this.lon, this.plusCode});

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      lat: json['lat'],
      lon: json['lon'],
      plusCode: json['plus_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'plus_code': plusCode,
    };
  }
}
