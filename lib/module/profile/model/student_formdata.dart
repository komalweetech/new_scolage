class StudentFormData {
  String name;
  String surname;

  StudentFormData({
    required this.name,
    required this.surname,
  });

  // Create a method to convert the Student object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
    };
  }

  // Create a factory method to create a Student object from a map
  factory StudentFormData.fromMap(Map<String, dynamic> map) {
    return StudentFormData(
      name: map['name'],
      surname: map['surname'],
    );
  }
}