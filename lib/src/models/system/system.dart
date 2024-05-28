class SystemModel {
  String language;
  String country;
  String timezone;
  String themeMode;
  SystemModel({
    required this.language,
    required this.country,
    required this.timezone,
    required this.themeMode,
  });
  //add copyWith method
  SystemModel copyWith({
    String? language,
    String? country,
    String? timezone,
    String? themeMode,
  }) {
    return SystemModel(
      language: language ?? this.language,
      country: country ?? this.country,
      timezone: timezone ?? this.timezone,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  //add fromJson method
  factory SystemModel.fromJson(Map<String, dynamic> json) {
    return SystemModel(
      language: json['language'],
      country: json['country'],
      timezone: json['timezone'],
      themeMode: json['themeMode'],
    );
  }
  //add toJson method
  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'country': country,
      'timezone': timezone,
      'themeMode': themeMode,
    };
  }
}
