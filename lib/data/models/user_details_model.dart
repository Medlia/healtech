class UserDetailsModel {
  final String gender;
  final String age;
  final String weight;

  UserDetailsModel({
    required this.gender,
    required this.age,
    required this.weight,
  });

  Map<String, String> toJson() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
    };
  }
}
