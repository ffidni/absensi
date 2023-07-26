import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'absen_form_model.g.dart';

@JsonSerializable()
@CopyWith()
class AbsenFormModel {
  @JsonKey(name: "user_id")
  String? userId;
  String? tipe;

  AbsenFormModel({
    this.userId,
    this.tipe,
  });

  Map<String, dynamic> toJson() => _$AbsenFormModelToJson(this);

  factory AbsenFormModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenFormModelFromJson(json);
}
