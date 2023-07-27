import 'package:absensi/models/tables/absen_model.dart';
import "package:json_annotation/json_annotation.dart";
import "package:copy_with_extension/copy_with_extension.dart";

part 'kehadiran_fetchs_model.g.dart';

@JsonSerializable()
@CopyWith()
class KehadiranFetchsModel {
  @JsonKey(name: "hadir_count_this_week")
  int? hadirCountThisWeek;
  @JsonKey(name: "hadir_count_this_month")
  int? hadirCountThisMonth;
  @JsonKey(name: "izin_count_this_week")
  int? izinCountThisWeek;
  @JsonKey(name: "izin_count_this_month")
  int? izinCountThisMonth;
  @JsonKey(name: "absen_data")
  List<AbsenModel>? absenData;

  KehadiranFetchsModel({
    this.hadirCountThisWeek,
    this.hadirCountThisMonth,
    this.izinCountThisMonth,
    this.izinCountThisWeek,
    this.absenData,
  });

  Map<String, dynamic> toJson() => _$KehadiranFetchsModelToJson(this);

  factory KehadiranFetchsModel.fromJson(Map<String, dynamic> json) =>
      _$KehadiranFetchsModelFromJson(json);
}
