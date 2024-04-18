class SystemModel {
  String language;
  String country;
  String timezone;
  String themeMode;

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

  SystemModel({
    required this.language,
    required this.country,
    required this.timezone,
    required this.themeMode,
  });
}
