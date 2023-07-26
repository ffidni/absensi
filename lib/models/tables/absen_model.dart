import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'absen_model.g.dart';

@JsonSerializable()
@CopyWith()
class AbsenModel {
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  String? nama;
  String? tipe;
  DateTime? tanggal;

  AbsenModel({
    this.id,
    this.userId,
    this.nama,
    this.tipe,
    this.tanggal,
  });

  Map<String, dynamic> toJson() => _$AbsenModelToJson(this);

  factory AbsenModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenModelFromJson(json);
}
