import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'user_model.g.dart';

@JsonSerializable()
@CopyWith()
class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  @JsonKey(name: "tipe_user")
  String? tipeUser;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.tipeUser,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
