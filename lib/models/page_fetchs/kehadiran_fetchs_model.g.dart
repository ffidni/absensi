// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kehadiran_fetchs_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KehadiranFetchsModelCWProxy {
  KehadiranFetchsModel hadirCountThisWeek(int? hadirCountThisWeek);

  KehadiranFetchsModel hadirCountThisMonth(int? hadirCountThisMonth);

  KehadiranFetchsModel izinCountThisMonth(int? izinCountThisMonth);

  KehadiranFetchsModel izinCountThisWeek(int? izinCountThisWeek);

  KehadiranFetchsModel absenData(List<AbsenModel>? absenData);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KehadiranFetchsModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KehadiranFetchsModel(...).copyWith(id: 12, name: "My name")
  /// ````
  KehadiranFetchsModel call({
    int? hadirCountThisWeek,
    int? hadirCountThisMonth,
    int? izinCountThisMonth,
    int? izinCountThisWeek,
    List<AbsenModel>? absenData,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKehadiranFetchsModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKehadiranFetchsModel.copyWith.fieldName(...)`
class _$KehadiranFetchsModelCWProxyImpl
    implements _$KehadiranFetchsModelCWProxy {
  const _$KehadiranFetchsModelCWProxyImpl(this._value);

  final KehadiranFetchsModel _value;

  @override
  KehadiranFetchsModel hadirCountThisWeek(int? hadirCountThisWeek) =>
      this(hadirCountThisWeek: hadirCountThisWeek);

  @override
  KehadiranFetchsModel hadirCountThisMonth(int? hadirCountThisMonth) =>
      this(hadirCountThisMonth: hadirCountThisMonth);

  @override
  KehadiranFetchsModel izinCountThisMonth(int? izinCountThisMonth) =>
      this(izinCountThisMonth: izinCountThisMonth);

  @override
  KehadiranFetchsModel izinCountThisWeek(int? izinCountThisWeek) =>
      this(izinCountThisWeek: izinCountThisWeek);

  @override
  KehadiranFetchsModel absenData(List<AbsenModel>? absenData) =>
      this(absenData: absenData);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KehadiranFetchsModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KehadiranFetchsModel(...).copyWith(id: 12, name: "My name")
  /// ````
  KehadiranFetchsModel call({
    Object? hadirCountThisWeek = const $CopyWithPlaceholder(),
    Object? hadirCountThisMonth = const $CopyWithPlaceholder(),
    Object? izinCountThisMonth = const $CopyWithPlaceholder(),
    Object? izinCountThisWeek = const $CopyWithPlaceholder(),
    Object? absenData = const $CopyWithPlaceholder(),
  }) {
    return KehadiranFetchsModel(
      hadirCountThisWeek: hadirCountThisWeek == const $CopyWithPlaceholder()
          ? _value.hadirCountThisWeek
          // ignore: cast_nullable_to_non_nullable
          : hadirCountThisWeek as int?,
      hadirCountThisMonth: hadirCountThisMonth == const $CopyWithPlaceholder()
          ? _value.hadirCountThisMonth
          // ignore: cast_nullable_to_non_nullable
          : hadirCountThisMonth as int?,
      izinCountThisMonth: izinCountThisMonth == const $CopyWithPlaceholder()
          ? _value.izinCountThisMonth
          // ignore: cast_nullable_to_non_nullable
          : izinCountThisMonth as int?,
      izinCountThisWeek: izinCountThisWeek == const $CopyWithPlaceholder()
          ? _value.izinCountThisWeek
          // ignore: cast_nullable_to_non_nullable
          : izinCountThisWeek as int?,
      absenData: absenData == const $CopyWithPlaceholder()
          ? _value.absenData
          // ignore: cast_nullable_to_non_nullable
          : absenData as List<AbsenModel>?,
    );
  }
}

extension $KehadiranFetchsModelCopyWith on KehadiranFetchsModel {
  /// Returns a callable class that can be used as follows: `instanceOfKehadiranFetchsModel.copyWith(...)` or like so:`instanceOfKehadiranFetchsModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KehadiranFetchsModelCWProxy get copyWith =>
      _$KehadiranFetchsModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KehadiranFetchsModel _$KehadiranFetchsModelFromJson(
        Map<String, dynamic> json) =>
    KehadiranFetchsModel(
      hadirCountThisWeek: json['hadir_count_this_week'] as int?,
      hadirCountThisMonth: json['hadir_count_this_month'] as int?,
      izinCountThisMonth: json['izin_count_this_month'] as int?,
      izinCountThisWeek: json['izin_count_this_week'] as int?,
      absenData: (json['absen_data'] as List<dynamic>?)
          ?.map((e) => AbsenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KehadiranFetchsModelToJson(
        KehadiranFetchsModel instance) =>
    <String, dynamic>{
      'hadir_count_this_week': instance.hadirCountThisWeek,
      'hadir_count_this_month': instance.hadirCountThisMonth,
      'izin_count_this_week': instance.izinCountThisWeek,
      'izin_count_this_month': instance.izinCountThisMonth,
      'absen_data': instance.absenData,
    };
