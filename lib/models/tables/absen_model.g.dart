// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absen_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AbsenModelCWProxy {
  AbsenModel id(int? id);

  AbsenModel userId(int? userId);

  AbsenModel nama(String? nama);

  AbsenModel tipe(String? tipe);

  AbsenModel tanggal(DateTime? tanggal);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsenModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsenModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsenModel call({
    int? id,
    int? userId,
    String? nama,
    String? tipe,
    DateTime? tanggal,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAbsenModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAbsenModel.copyWith.fieldName(...)`
class _$AbsenModelCWProxyImpl implements _$AbsenModelCWProxy {
  const _$AbsenModelCWProxyImpl(this._value);

  final AbsenModel _value;

  @override
  AbsenModel id(int? id) => this(id: id);

  @override
  AbsenModel userId(int? userId) => this(userId: userId);

  @override
  AbsenModel nama(String? nama) => this(nama: nama);

  @override
  AbsenModel tipe(String? tipe) => this(tipe: tipe);

  @override
  AbsenModel tanggal(DateTime? tanggal) => this(tanggal: tanggal);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsenModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsenModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsenModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? nama = const $CopyWithPlaceholder(),
    Object? tipe = const $CopyWithPlaceholder(),
    Object? tanggal = const $CopyWithPlaceholder(),
  }) {
    return AbsenModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int?,
      nama: nama == const $CopyWithPlaceholder()
          ? _value.nama
          // ignore: cast_nullable_to_non_nullable
          : nama as String?,
      tipe: tipe == const $CopyWithPlaceholder()
          ? _value.tipe
          // ignore: cast_nullable_to_non_nullable
          : tipe as String?,
      tanggal: tanggal == const $CopyWithPlaceholder()
          ? _value.tanggal
          // ignore: cast_nullable_to_non_nullable
          : tanggal as DateTime?,
    );
  }
}

extension $AbsenModelCopyWith on AbsenModel {
  /// Returns a callable class that can be used as follows: `instanceOfAbsenModel.copyWith(...)` or like so:`instanceOfAbsenModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AbsenModelCWProxy get copyWith => _$AbsenModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenModel _$AbsenModelFromJson(Map<String, dynamic> json) => AbsenModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      nama: json['nama'] as String?,
      tipe: json['tipe'] as String?,
      tanggal: json['tanggal'] == null
          ? null
          : DateTime.parse(json['tanggal'] as String),
    );

Map<String, dynamic> _$AbsenModelToJson(AbsenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'nama': instance.nama,
      'tipe': instance.tipe,
      'tanggal': instance.tanggal?.toIso8601String(),
    };
