class User {
  String pseudo;
  String email;
  String? about;
  DateTime birthDate;
  String? imagePath;
  String? city;
  String? gender;
  bool isDarkMode;

  User({
    required this.pseudo,
    required this.email,
    this.about,
    required this.birthDate,
    this.imagePath,
    this.city,
    this.gender,
    this.isDarkMode = false,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      pseudo: map['pseudo'],
      email: map['email'],
      about: map['about'],
      birthDate: DateTime.parse(map['birthDate']),
      imagePath: map['imagePath'],
      city: map['city'],
      gender: map['gender'],
      isDarkMode: map['isDarkMode'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pseudo': pseudo,
      'email': email,
      'about': about,
      'birthDate': birthDate.toIso8601String(),
      'imagePath': imagePath,
      'city': city,
      'gender': gender,
      'isDarkMode': isDarkMode,
    };
  }
}
