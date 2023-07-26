import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'login_form_model.g.dart';

@JsonSerializable()
@CopyWith()
class LoginFormModel {
  String? email;
  String? password;

  LoginFormModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => _$LoginFormModelToJson(this);

  factory LoginFormModel.fromJson(Map<String, dynamic> json) =>
      _$LoginFormModelFromJson(json);
}
