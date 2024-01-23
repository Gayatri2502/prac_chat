class GroupModel {
  GroupModel({
    required this.groupID,
    required this.groupName,
    required this.createdBy,
    required this.createdAt,
    this.groupPic,
    this.sentAt,
    required this.members,
  });

  late final String groupID;
  late final String groupName;
  late final String createdBy;
  late final String createdAt;
  late final DateTime? sentAt;
  String? groupPic = " ";
  late final List<String> members;

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupID = json["groupID"] ?? "";
    groupName = json['groupName'] ?? "";
    createdBy = json['createdBy'] ?? "";
    createdAt = json['createdAt'] ?? "";
    groupPic = json['groupPic'] ?? "";
    sentAt = DateTime.fromMillisecondsSinceEpoch(json['sentAt']);
    members = List<String>.from(json['members'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['groupID'] = groupID;
    data['groupName'] = groupName;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['groupPicture'] = groupPic;
    data['members'] = members;
    return data;
  }
}
