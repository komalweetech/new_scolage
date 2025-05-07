class HelpMessage {
  final String message;
  final String studentId;
  final DateTime timestamp;

  HelpMessage({
    required this.message,
    required this.studentId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'studentId': studentId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HelpMessage.fromJson(Map<String, dynamic> json) {
    return HelpMessage(
      message: json['message'],
      studentId: json['studentId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
} 