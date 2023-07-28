// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absen_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AbsenModelCWProxy {
  AbsenModel id(int? id);

  AbsenModel userId(int? userId);

  AbsenModel status(String? status);

  AbsenModel user(UserModel? user);

  AbsenModel tipe(String? tipe);

  AbsenModel telatWaktu(int? telatWaktu);

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
    String? status,
    UserModel? user,
    String? tipe,
    int? telatWaktu,
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
  AbsenModel status(String? status) => this(status: status);

  @override
  AbsenModel user(UserModel? user) => this(user: user);

  @override
  AbsenModel tipe(String? tipe) => this(tipe: tipe);

  @override
  AbsenModel telatWaktu(int? telatWaktu) => this(telatWaktu: telatWaktu);

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
    Object? status = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? tipe = const $CopyWithPlaceholder(),
    Object? telatWaktu = const $CopyWithPlaceholder(),
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
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserModel?,
      tipe: tipe == const $CopyWithPlaceholder()
          ? _value.tipe
          // ignore: cast_nullable_to_non_nullable
          : tipe as String?,
      telatWaktu: telatWaktu == const $CopyWithPlaceholder()
          ? _value.telatWaktu
          // ignore: cast_nullable_to_non_nullable
          : telatWaktu as int?,
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
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tipe: json['tipe'] as String?,
      telatWaktu: json['telat_waktu'] as int?,
      tanggal: json['tanggal'] == null
          ? null
          : DateTime.parse(json['tanggal'] as String),
    );

Map<String, dynamic> _$AbsenModelToJson(AbsenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user': instance.user,
      'status': instance.status,
      'tipe': instance.tipe,
      'telat_waktu': instance.telatWaktu,
      'tanggal': instance.tanggal?.toIso8601String(),
    };
