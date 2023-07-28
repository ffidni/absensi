// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absen_form_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AbsenFormModelCWProxy {
  AbsenFormModel userId(String? userId);

  AbsenFormModel tipe(String? tipe);

  AbsenFormModel tanggal(String? tanggal);

  AbsenFormModel status(String? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsenFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsenFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsenFormModel call({
    String? userId,
    String? tipe,
    String? tanggal,
    String? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAbsenFormModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAbsenFormModel.copyWith.fieldName(...)`
class _$AbsenFormModelCWProxyImpl implements _$AbsenFormModelCWProxy {
  const _$AbsenFormModelCWProxyImpl(this._value);

  final AbsenFormModel _value;

  @override
  AbsenFormModel userId(String? userId) => this(userId: userId);

  @override
  AbsenFormModel tipe(String? tipe) => this(tipe: tipe);

  @override
  AbsenFormModel tanggal(String? tanggal) => this(tanggal: tanggal);

  @override
  AbsenFormModel status(String? status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsenFormModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsenFormModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsenFormModel call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? tipe = const $CopyWithPlaceholder(),
    Object? tanggal = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return AbsenFormModel(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      tipe: tipe == const $CopyWithPlaceholder()
          ? _value.tipe
          // ignore: cast_nullable_to_non_nullable
          : tipe as String?,
      tanggal: tanggal == const $CopyWithPlaceholder()
          ? _value.tanggal
          // ignore: cast_nullable_to_non_nullable
          : tanggal as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
    );
  }
}

extension $AbsenFormModelCopyWith on AbsenFormModel {
  /// Returns a callable class that can be used as follows: `instanceOfAbsenFormModel.copyWith(...)` or like so:`instanceOfAbsenFormModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AbsenFormModelCWProxy get copyWith => _$AbsenFormModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenFormModel _$AbsenFormModelFromJson(Map<String, dynamic> json) =>
    AbsenFormModel(
      userId: json['user_id'] as String?,
      tipe: json['tipe'] as String?,
      tanggal: json['tanggal'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AbsenFormModelToJson(AbsenFormModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'tipe': instance.tipe,
      'tanggal': instance.tanggal,
      'status': instance.status,
    };
