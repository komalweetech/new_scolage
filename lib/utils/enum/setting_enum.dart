enum LanguagesEnum {
  english(displayName: "English"),
  hindi(displayName: "हिंदी"),
  telugu(displayName: "తెలుగు"),
  tamil(displayName: "தமிழ்");

  final String displayName;

  const LanguagesEnum({
    required this.displayName,
  });
}
