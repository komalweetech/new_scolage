class ReviewDataModel {
  final String id;
  final String collegeId;
  final String studentId;
  final String reviewId;
  final String text;
  final int reviewStar;
  final bool isUpdated;
  final int createdAt;
  final int v;

  ReviewDataModel({
    required this.id,
    required this.collegeId,
    required this.studentId,
    required this.reviewId,
    required this.text,
    required this.reviewStar,
    required this.isUpdated,
    required this.createdAt,
    required this.v,
  });

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      id: json['_id'],
      collegeId: json['collegeid'],
      studentId: json['studentid'],
      reviewId: json['reviewid'],
      text: json['text'],
      reviewStar: json['reviewStar'],
      isUpdated: json['isUpdated'] == 'true',
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }
}
