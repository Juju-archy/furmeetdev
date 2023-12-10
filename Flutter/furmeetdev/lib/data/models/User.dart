class User {
  String pseudo;
  String email;
  String? about;
  String birthDate;
  //String? imagePath;
  String? city;
  String? gender;
  String password;
  String salt;
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
    required this.salt,
    this.isDarkMode = 0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      pseudo: map['upseudo'],
      email: map['uemail'],
      about: map['uabout'],
      birthDate: map['ubirthday'],
      //imagePath: map['imagePath'],
      city: map['ucity'],
      gender: map['ugender'],
      password: map['UPASS'],
      salt: map['SALT'],
      isDarkMode: int.parse(map['isdarkmode'] ?? '0'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'upseudo': pseudo,
      'uemail': email,
      'uabout': about,
      'ubirthday': birthDate,
      //'imagePath': imagePath,
      'ucity': city,
      'ugender': gender,
      'UPASS': password,
      'SALT': salt,
      'isdarkmode': isDarkMode,
    };
  }
}
