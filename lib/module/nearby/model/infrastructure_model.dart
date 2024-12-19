class CollegeSocialMedia {
  final String id;
  final String website;
  final String facebook;
  final String youtube;
  final String instagram;

  CollegeSocialMedia({
    required this.id,
    required this.website,
    required this.facebook,
    required this.youtube,
    required this.instagram,
  });

  factory CollegeSocialMedia.fromJson(Map<String, dynamic> json) {
    return CollegeSocialMedia(
      id: json['_id'] ?? '',
      website: json['website'] ?? '',
      facebook: json['facebook'] ?? '',
      youtube: json['youtube'] ?? '',
      instagram: json['instagram'] ?? '',
    );
  }
}

class InfrastructureModel {
  final String name;
  final String icon;


  InfrastructureModel({
    required this.name,
    required this.icon,
  });
}
class InfraModel {
  final String name;
  final String icon;
  final bool value;


  InfraModel({
    required this.name,
    required this.icon,
    required this.value,
  });
}

