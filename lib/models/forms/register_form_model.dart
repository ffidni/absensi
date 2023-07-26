import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'register_form_model.g.dart';

@JsonSerializable()
@CopyWith()
class RegisterFormModel {
  String? name;
  String? email;
  String? password;

  RegisterFormModel({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => _$RegisterFormModelToJson(this);

  factory RegisterFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterFormModelFromJson(json);
}
