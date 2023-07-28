import "package:absensi/models/tables/user_model.dart";
import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'absen_model.g.dart';

@JsonSerializable()
@CopyWith()
class AbsenModel {
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  UserModel? user;
  String? status;
  String? tipe;
  @JsonKey(name: "telat_waktu")
  int? telatWaktu;
  DateTime? tanggal;

  AbsenModel({
    this.id,
    this.userId,
    this.status,
    this.user,
    this.tipe,
    this.telatWaktu,
    this.tanggal,
  });

  Map<String, dynamic> toJson() => _$AbsenModelToJson(this);

  factory AbsenModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenModelFromJson(json);
}
