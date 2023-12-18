import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelTojson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.image,
    required this.id,
    required this.name,
    required this.email,
    this.notificationToken,
  });

  String? image;
  String name;
  String email;

  String id;
  String? notificationToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        notificationToken: json["notificationToken"] ?? "",
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "notificationToken": notificationToken,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
      );
}
