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

class UserResponse {
  UserResponse({
    required this.jwt,
    required this.user,
  });

  String jwt;
  UserModel user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    jwt: json["jwt"],
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "jwt": jwt,
    "user": user.toJson(),
  };
}

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    provider: json["provider"],
    confirmed: json["confirmed"],
    blocked: json["blocked"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "provider": provider,
    "confirmed": confirmed,
    "blocked": blocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
