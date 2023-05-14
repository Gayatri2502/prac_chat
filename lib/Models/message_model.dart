import 'package:prac_chat/Models/user_model.dart';

class MessageModel {
  late final String mesgId;
  late final String message;
  late final String imageLink;
  late final DateTime sentAt;
  late final UserModel sentBy;
  late final List<UserModel> seenBy;

  MessageModel(
      {required this.mesgId,
      required this.message,
      required this.imageLink,
      required this.sentAt,
      required this.sentBy,
      required this.seenBy});

  // MessageModel.fromJson(Map<String, dynamic> json) {
  //   mesgId = json['mesgId'] ?? "";
  //   message = json['message'] ?? "";
  //   imageLink = json['imageLink'] ?? "";
  //   sentAt = json['sentAt'] ?? "";
  //   sentBy = json['sentBy'] ?? "";
  //   seenBy = json['seenBy'] ?? "";
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['mesgId'] = mesgId;
  //   _data['message'] = message;
  //   _data['imageLink'] = imageLink;
  //   _data['sentAt'] = sentAt;
  //   _data['sentBy'] = sentBy;
  //   _data['seenBy'] = seenBy;
  //   return _data;
  // }

  //from Json
  MessageModel.fromJson(Map<String, dynamic> json)
      : mesgId = json['mesgId'],
        message = json['message'],
        imageLink = json['imageLink'],
        sentAt = DateTime.fromMillisecondsSinceEpoch(json['sentAt']),
        sentBy = UserModel.fromJson(json['sentBy']),
        seenBy =
            (json['seenBy'] as List).map((e) => UserModel.fromJson(e)).toList();

//to Json
  Map<String, dynamic> toJson() => {
        'mesgId': mesgId,
        'message': message,
        'imageLink': imageLink,
        'sentAt': sentAt.millisecondsSinceEpoch,
        'sentBy': sentBy.toJson(),
        'seenBy': seenBy.map((e) => e.toJson()).toList()
      };
}

String createChannelId(String user1, String user2) {
  List<String> userIds = [user1, user2];
  userIds.sort();
  String channelId = userIds.join("");
  return channelId;
}
