class User {
  String pseudo;
  String email;
  String? about;
  String birthDate;
  //String? imagePath;
  String? city;
  String? gender;
  String password;
  int isDarkMode;

  User({
    required this.pseudo,
    required this.email,
    this.about,
    required this.birthDate,
    //this.imagePath,
    this.city,
    this.gender,
    required this.password,
    this.isDarkMode = 0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      pseudo: map['upseudo'], // Assurez-vous que le nom correspond à votre API
      email: map['uemail'], // Assurez-vous que le nom correspond à votre API
      about: map['uabout'],
      birthDate: map['ubirthday'],
      //imagePath: map['imagePath'],
      city: map['ucity'],
      gender: map['ugender'],
      password: map['UPASS'], // Assurez-vous que le nom correspond à votre API
      isDarkMode: int.parse(map['isdarkmode'] ?? '0'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'upseudo': pseudo, // Assurez-vous que le nom correspond à votre API
      'uemail': email, // Assurez-vous que le nom correspond à votre API
      'uabout': about,
      'ubirthday': birthDate,
      //'imagePath': imagePath,
      'ucity': city,
      'ugender': gender,
      'UPASS': password, // Assurez-vous que le nom correspond à votre API
      'isdarkmode': isDarkMode,
    };
  }
}
