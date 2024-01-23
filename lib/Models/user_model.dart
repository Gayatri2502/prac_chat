// ignore_for_file: no_leading_underscores_for_local_identifiers

class UserModel {
  UserModel(
      {required this.userID,
      required this.email,
      required this.phoneNumber,
      required this.name,
      required this.password,
      required this.bio,
      required this.photo,
      required this.createdAT,
      required this.isOnline,
      required this.lastActive,
      required this.pushToken});

  late final String userID;
  late final String email;
  late final String phoneNumber;
  late final String name;
  late final String password;
  late final String bio;
  late final String photo;
  late final String createdAT;
  late final bool isOnline;
  late final String lastActive;
  late final String pushToken;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.userID == userID;
  }

  @override
  int get hashCode => userID.hashCode;

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json["userID"] ?? "";
    email = json['Email'] ?? "";
    phoneNumber = json['PhoneNumber'] ?? "";
    name = json['Name'] ?? "";
    password = json['Password'] ?? "";
    bio = json['Bio'] ?? "";
    photo = json['Photo'] ?? "";
    createdAT = json['CreatedAT'] ?? "";
    isOnline = json['isOnline'] ?? false;
    lastActive = json['lastActive'] ?? "";
    pushToken = json['PushToken'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userID;
    _data['Email'] = email;
    _data['PhoneNumber'] = phoneNumber;
    _data['Name'] = name;
    _data['Password'] = password;
    _data['Bio'] = bio;
    _data['Photo'] = photo;
    _data['CreatedAT'] = createdAT;
    _data['isOnline'] = isOnline;
    _data['lastActive'] = lastActive;
    _data['pushToken'] = pushToken;
    return _data;
  }
}
