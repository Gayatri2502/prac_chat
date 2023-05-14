class UserModel {
  UserModel(
      {required this.userID,
      required this.Email,
      required this.PhoneNumber,
      required this.Name,
      required this.Password,
      required this.Bio,
      required this.Photo,
      required this.createdAT,
      required this.isOnline,
      required this.lastActive,
      required this.pushToken});
  late final String userID;
  late final String Email;
  late final String PhoneNumber;
  late final String Name;
  late final String Password;
  late final String Bio;
  late final String Photo;
  late final String createdAT;
  late final bool isOnline;
  late final String lastActive;
  late final String pushToken;

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json["userID"] ?? "";
    Email = json['Email'] ?? "";
    PhoneNumber = json['PhoneNumber'] ?? "";
    Name = json['Name'] ?? "";
    Password = json['Password'] ?? "";
    Bio = json['Bio'] ?? "";
    Photo = json['Photo'] ?? "";
    createdAT = json['CreatedAT'] ?? "";
    isOnline = json['isOnline'] ?? false;
    lastActive = json['lastActive'] ?? "";
    pushToken = json['PushToken'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userID;
    _data['Email'] = Email;
    _data['PhoneNumber'] = PhoneNumber;
    _data['Name'] = Name;
    _data['Password'] = Password;
    _data['Bio'] = Bio;
    _data['Photo'] = Photo;
    _data['CreatedAT'] = createdAT;
    _data['isOnline'] = isOnline;
    _data['lastActive'] = lastActive;
    _data['pushToken'] = pushToken;
    return _data;
  }
}
