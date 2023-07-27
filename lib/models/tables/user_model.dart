import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'user_model.g.dart';

@JsonSerializable()
@CopyWith()
class UserModel {
  int? id;
  String? nama;
  String? email;
  String? password;
  @JsonKey(name: "tipe_user")
  String? tipeUser;
  final String? token;
  @JsonKey(name: 'token_expires_in')
  final int? tokenExpiresIn;
  @JsonKey(name: 'token_type')
  final String? tokenType;

  UserModel({
    this.id,
    this.nama,
    this.email,
    this.password,
    this.tipeUser,
    this.token,
    this.tokenExpiresIn,
    this.tokenType,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
