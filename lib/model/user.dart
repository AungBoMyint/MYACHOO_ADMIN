import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AuthUser {
  final String id;
  final String emailAddress;
  final String userName;
  final String image;
  final int points;
  final int? status;
  AuthUser({
    required this.id,
    required this.emailAddress,
    required this.userName,
    required this.image,
    required this.points,
    this.status = 0,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
